require 'nanoc/toolbox'

include Nanoc::Toolbox::Helpers::Gravatar

module Nanoc::Helpers
  module StaticComments

    def comment_author_link(comment)
      if comment[:website]
        link_to(comment[:author], comment[:website])
      else
        comment[:author]
      end
    end

    def gravatar_image_for_comment(comment)
      email = 'nobody@hazyblue.me'
      email = comment[:email] if comment[:email] and comment[:email].length > 0
      gravatar_image(email, :size => '50')
    end

    # Find all the comments for a post
    def comments_for_post(post)
      comments = @items.select { |item| item.identifier =~ /^\/comments\// and item[:post_id] == post.identifier }
      comments.sort_by { |a| attribute_to_time(a[:created_at]) } 
    end

  end
end

