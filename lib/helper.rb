include Nanoc::Helpers::StaticComments
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering

require 'uri'
require 'summarize'

module PostHelper
  def pretty_date(post, format='%B %-d, %Y')
    attribute_to_time(post[:created_at]).strftime(format)
  end

  def pub_datetime(post)
    DateTime.parse(attribute_to_time(post[:created_at]).strftime('%B %-d, %Y %H:%M %z')).rfc3339
  end

  def pubtime_tag(time)
    "<time pubdate datetime='#{time}'>" +
      attribute_to_time(time).strftime('%B %-d, %Y at %l:%M %P') +
      "</time>"
  end

  def post_raw_start(post)
    raw_content = post.raw_content
    if raw_content =~ /\s<!-- more -->\s/
      raw_content.partition('<!-- more -->').first
    else
      raw_content
    end
  end

  def post_topics(post)
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => '',        # Use a blank for those replacements
      :universal_newline => true       # Always break lines with \n
    }
    post.raw_content.encode(Encoding.find('ASCII'), encoding_options).summarize(:topics => true)
  end

  def post_summary(post)
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => '',        # Use a blank for those replacements
      :universal_newline => true       # Always break lines with \n
    }
    raw_content = post_raw_start(post)
    Kramdown::Document.new(raw_content).to_html.encode(Encoding.find('ASCII'), encoding_options).summarize(:ratio => 25)
  end

  def post_start(post)
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

  def image_link(image, href)
    "<a href='#{href}'><img src='#{image}' /></a>"
  end

  def grouped_articles
    sorted_articles.select{ |post| post[:published] }.group_by do |post|
      [ attribute_to_time(post[:created_at]).strftime('%Y'), attribute_to_time(post[:created_at]).strftime('%B') ]
    end
  end

  def tweet_this_url(post)
    post_url = URI::encode(url_for(post))
    "https://twitter.com/intent/tweet?original_referer=#{post_url}&text=#{post[:title]}&url=#{post_url}&via=hazybluedot"
  end

  def share_on_gplus_url(post)
    post_url = URI::encode(url_for(post))
    "https://plus.google.com/share?url=#{post_url}"
  end
end

include PostHelper
