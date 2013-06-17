include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering

module PostHelper

  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end

  def time_tag(post)
    "<time pubtime datetime='#{post[:created_at]}'>#{get_pretty_date(post)}</time>"
  end

  def get_post_start(post)
    content = post.compiled_content
    if content =~ /\s<!-- more -->\s/
      content = content.partition('<!-- more -->').first +
        "<footer><div class='read-more'><a href='#{post.path}'>Continue reading &rsaquo;</a></div></footer>"
    end
    return content
  end

  def image_tag(image)
    content = "<img src='#{image}' />"
  end

  def grouped_articles
    sorted_articles.group_by do |a|
      [ Date.parse(a[:created_at]).year, Date.parse(a[:created_at]).month ]
    end.sort
  end
end

class YouTubeFilter < Nanoc::Filter
  identifier :youtube
  type :text
  
  def run(content, params={})
#    content.gsub(/[a-z]+/, 'nanoc rules')
    content.each_line.map do |line|
      url = line.gsub('\_','_')
      youtube_id = nil
      if url[/^\s*(?:https?:\/\/)?(?:www\.)?(?:youtube\.com(?:\/(?:watch(?:\?(?:\w+=\w+&)+|\?)v=?))|youtu\.be\/)(.+)/]
        youtube_id = $1
      end
      
      if youtube_id
        line  = %Q{<p><iframe title="YouTube video player" width="584" height="329" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe></p>}
      else
        line
      end
    end.join("")
  end
end

include PostHelper
