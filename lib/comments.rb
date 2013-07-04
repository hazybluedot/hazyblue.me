require 'nanoc/toolbox'

include Nanoc::Toolbox::Helpers::Gravatar

module StaticComments
  def comment_author_link(comment)
    if comment['website']
      link_to(comment['author'], comment['website'])
    else
      comment['author']
    end
  end
  # Find all the comments for a post
  def comments_for_post(post)
    # puts "Looking for comments in #{post.identifier}"
    comments = []
    Dir["comments#{post.identifier.chop}/*"].select{ |i| i[/.*[^~]$/] }.sort.each do |comment_file|
      meta, content = parse(comment_file)
      meta['comment'] = content
      meta['email'] = 'nobody@hazyblue.me' unless meta['email'] and meta['email'].length > 0
      meta['gravatar_image'] = gravatar_image(meta['email'], :size => '75', :default_icon => 'monsterid')
      meta['gravatar_url'] = gravatar_url(meta['email'])

      comments.push(meta)
    end
    comments.sort_by { |a| attribute_to_time(a['created_at']) } 
  end
  
  # Read all the comments files in the site, and return them as a hash of
  # arrays containing the comments, where the key to the array is the value
  # of the 'post_id' field in the YAML data in the comments files.
  def read_comments(source)
    comments = Hash.new() { |h, k| h[k] = Array.new }
    
    Dir["#{source}/**/_comments/**/*"].sort.each do |comment|
      next unless File.file?(comment) and File.readable?(comment)
      yaml_data = YAML::load_file(comment)
      post_id = yaml_data.delete('post_id')
      comments[post_id] << yaml_data
    end
    
    comments
  end

  def parse(content_filename)
    data = File.read(content_filename)
    # Check presence of metadata section
    if data !~ /\A-{3,5}\s*$/
      return [ {}, data ]
    end

    # Split data
    pieces = data.split(/^(-{5}|-{3})\s*$/)
    if pieces.size < 4
      raise RuntimeError.new(
                             "The file '#{content_filename}' appears to start with a metadata section (three or five dashes at the top) but it does not seem to be in the correct format."
                             )
    end

    # Parse
    begin
      meta = YAML.load(pieces[2]) || {}
    rescue Exception => e
      raise "Could not parse YAML for #{content_filename}: #{e.message}"
    end
    content = pieces[4..-1].join.strip

    # Done
    [ meta, content ]
  end
end

include StaticComments
