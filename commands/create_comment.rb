require 'stringex'

usage 'create_comment [options] article name'
aliases :create_comment, :cc
description 'Manually create a comment for an item'

option :t, :created_at, 'post date of comment', :argument => :required
option :a, :author, 'author of comment', :argument => :required

class CreateItemComment < Nanoc::CLI::Commands::CreateItem
  def parse_input data
    meta = {}
    content = ''
    at_content = false
    data.each_line do |line|
      if !at_content
        meta[:author] = line.chomp unless meta[:author]
        meta[:website] = line.gsub(/(.*)\s+x$/, '\1').chomp if line =~ /\s+x$/ and !meta[:website]
        meta[:email] = line.chomp if line =~ /[a-zA-Z0-9\.-]@[a-zA-Z0-9\.-]/ and !meta[:email]
        if line =~ /^Submitted on (.*)$/
          at_content = true
          meta[:created_at] = Time.parse($1)
        end
      else
        content += line
      end
    end
    return [ meta, content ]
  end

  def run
    puts "creating comment with arguments: " + arguments.inspect
    puts "options: " + options.inspect
    self.require_site

    identifier = arguments[0].to_url

    parent = self.site.items.select { |i| !(i.identifier =~ /^\/comments/) and i.identifier =~ /#{identifier}/ and !i.binary? }
    
    if parent.length <= 0
      raise Nanoc::Errors::GenericTrivial,
      "Could not find parent post matching #{identifier}"
    end
    
    if parent.length != 1
      raise Nanoc::Errors::GenericTrivial,
      "Multiple items match expression #{arguments[0]}:\n" +  (parent.map { |p| p.identifier }).join("\n")
    end

    datetime_format = '%Y-%m-%d %H:%M:%S %z'

    meta, content = parse_input(STDIN)

    meta[:post_id] = parent.identifier
    created_at = meta[:created_at].strftime(datetime_format) || Time.now.strftime(datetime_format)
    comment_id = "/comments/" + identifier + "/"
    comment_id += [ meta[:author], created_at ].map { |a| a.to_url }.join('-')
    puts "creating comment: " + comment_id

    # Create the comment
    data_source = self.site.data_sources[0]
    data_source.create_item( 
                            content,
                            meta,
                            comment_id,
                            { :extension => '.md' }
                            )
  end
end

runner CreateItemComment
