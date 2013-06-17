require 'open-uri'
require 'twitter'
require 'stringex'

Twitter.configure do |config|
  config.consumer_key = 'ZJS6LNLkC0t6A4bDxTokWA'
  config.consumer_secret = 'wHlBclbFJZqb0PaGsD1j5To6I7r0afnWkXSUnRJkWGE'
  config.oauth_token = '15381538-LjIeCqKtD9u8dBh7mW3RtK5msM4LdIImT6hAsD0'
  config.oauth_token_secret = 'FVaQCL2ghLuaV6TvV1xQzDAfvOw9CMmrDRqcAQv4'
end

desc "Create a new post"
task :new_post, :title do |t, args|
  mkdir_p './content/posts'
  args.with_defaults(:title => 'New Post')
  title = args.title
  filename = "./content/posts/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.md"
  
  if File.exist?(filename)
    abort('rake aborted!') if ask("#{filename} already exists. Want to overwrite?", ['y','n']) == 'n'
  end

  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts '---'
    post.puts "title: \"#{title}\""
    post.puts "created_at: #{Time.now}"
    post.puts 'kind: article'
    post.puts 'published: false'
    post.puts "---\n\n"
    post.puts "<!-- more -->\n\n"
  end
end

desc "Fetch recent tweets"
task :fetch_twitter do
  # Configure
  username = 'hazybluedot'
  
  # Read
  timeline = Twitter.user_timeline(username)
  # Write
  FileUtils.mkdir_p('tmp')
  File.open("tmp/twitter-#{username}.json", 'w') { |io| io.write(timeline) }
end
