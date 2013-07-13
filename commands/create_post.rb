usage 'create_post [options] title'
aliases :create_post, :cp
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
      :tags => nil
    }

    identifier = "/posts/" + [ Time.parse(meta[:created_at]).strftime('%Y-%m-%d'), meta[:title] ].map { |a| a.to_url }.join('-') 
    puts "creating post: " + identifier
    puts "with meta data: " + meta.inspect
    content = <<EOF
tl;dr

<!-- more -->

rest of stuff
EOF

    editor_cmd = 'emacsclient --server-file=blog {}'
    file_extension = '.md'
    # Create the post
    data_source = self.site.data_sources[0]
    data_source.create_item( 
    content,
                            meta,
                            identifier,
                            { :extension => file_extension }
                            )
    system(editor_cmd.gsub(/{}/, "content"+identifier+file_extension))
  end
end

runner CreateItemComment
