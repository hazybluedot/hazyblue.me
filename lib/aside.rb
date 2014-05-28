# encoding: utf-8

module Nanoc::Aside
  class Filter < Nanoc::Filter
    identifier :aside
    
    def run(content, params = {})
      content.gsub(/\(aside:(?:\[([^\]]*)\])? ([^\)]*)\)/) do |match|
        "<aside><header>#{$1.nil? ? 'aside' : $1}</header>#{$2}</aside>"
      end
    end 
  end
end
