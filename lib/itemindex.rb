module Nanoc::Helpers
  module ItemIndex
    def item_index(items, title, identifier=nil, opts: {} )
      Nanoc::Item.new("", {
                        :title => title,
                        :kind => 'item_index',
                        :items => items,
                        :item_layout => nil },
                      identifier
                      ) 
    end
  end
end

include Nanoc::Helpers::ItemIndex
