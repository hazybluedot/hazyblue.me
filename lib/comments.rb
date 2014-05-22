require 'nanoc/toolbox'

include Nanoc::Toolbox::Helpers::Gravatar

module Nanoc::Helpers
  module LinkTo
    def external_url base
      if base =~ /^https?:\/\//
        base
      else
        base = 'http://' + base
      end
    end
  end
end

module Nanoc::Helpers
  module StaticComments

    def comment_author_link(comment)
      if comment[:website] and comment[:website].length > 0
        link_to(comment[:author], external_url(comment[:website]))
      else
        comment[:author]
      end
    end

    def gravatar_image_for_comment(comment)
      email = 'nobody@hazyblue.me'
      email = comment[:email] if comment[:email] and comment[:email].length > 0
      gravatar_image(email, :size => '75')
    end

    # Find and return all the comments for a post
    # @param [Nanoc::Item] the nanoc item used to match comments to
    # @return [Array<Nanoc::Item>] The comments for the supplied item, if any    
    def comments_for_post(post)
      comments = @site.items.select { |item| item.identifier =~ /^\/comments\// and item[:post_id] == post.identifier }
      comments.sort_by { |a| attribute_to_time(a[:created_at]) } 
    end

  end
end

include Nanoc::Helpers::StaticComments

module Nanoc
  class Item
    # @return [Array<Nanoc::Item>] The comments for this item, if any
    def comments
      comments_for_post(self)
    end
  end
end
