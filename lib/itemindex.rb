module Nanoc::Helpers
  module ItemIndex
    def regexp(string_or_regexp)
      Regexp === string_or_regexp ? string_or_regexp : Regexp.compile(Regexp.escape(string_or_regexp))
    end

    def item_index_for(path, title, identifier)
      $stderr.puts("Searching for items matching #{regexp(path)}")
      return item_index( @items.select { |i| i.identifier =~ regexp(path) }, title, identifier) 
    end

    def item_index(items, title, identifier=nil, opts: {} )
      $stderr.puts("Generating item index '#{title}' with #{items.count} items")
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
