usage 'create_post [options] title'
aliases :create_post, :edit_post, :cp
description 'Create a new blog post'

option :c, :vcs, 'versioning control system', :argument => :required

class CreateItemComment < Nanoc::CLI::Commands::CreateItem
  def run
    self.require_site

    # Set VCS if possible
    self.set_vcs(options[:vcs])

    datetime_format = '%Y-%m-%d %H:%M:%S %z'

    meta = {
      :title => arguments[0],
      :published => false,
      :kind => 'article',
      :created_at => Time.now.strftime(datetime_format),
      :author_name => @site.config[:author_name],
      :tags => nil
    }

    identifier = "/posts/" + [ Time.parse(meta[:created_at]).strftime('%Y-%m-%d'), meta[:title] ].map { |a| a.to_url }.join('-') + "/"
    exists = @site.items.find { |i| i.identifier == identifier }

    editor_cmd = 'emacsclient --server-file=blog {}'
    file_extension = '.md'

    if (!exists)
      puts "creating post: " + identifier
      content = <<EOF
tl;dr

<!-- more -->

rest of stuff
EOF

    # Create the post
      data_source = self.site.data_sources[0]
      data_source.create_item( 
                              content,
                              meta,
                              identifier,
                              { :extension => file_extension }
                              )
    end
    puts "Opening in editor: content"+identifier+file_extension
    system(editor_cmd.gsub(/{}/, "content"+identifier[0..-2]+file_extension))
  end
end

runner CreateItemComment
