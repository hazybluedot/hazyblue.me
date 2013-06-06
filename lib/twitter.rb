class Twitter < Nanoc::DataSource
  def items
    @item ||= begin
      require 'json'
      require 'time'
      require 'enumerator'
             
      # Parse data
      filename = "tmp/twitter-#{username}.json"
      if !File.file?(filename)
        raise RuntimeError, "No tweets available for #{username} (#{filename} does not exist)"
      end
      data = File.read(filename)
      raw_items = JSON.parse(data)

      # Convert to items
      raw_items.enum_with_index.map do |raw_item, i|
        # Get data
        content = raw_item['text']
        attributes = {
          :created_at  => raw_item['created_at'],
          :source      => raw_item['source']
          # TODO add more
        }
        identifier = "/#{raw_item['id']}/"
        mtime = Time.parse(raw_item['created_at'])

        # Build item
        Nanoc::Item.new(content, attributes, identifier, mtime)
      end
    end
  end
end
