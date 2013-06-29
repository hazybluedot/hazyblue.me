module StaticComments
	# Find all the comments for a post
	def self.find_for_post(post)
		@comments ||= read_comments(post.site.source)
		@comments[post.id]
	end
	
	# Read all the comments files in the site, and return them as a hash of
	# arrays containing the comments, where the key to the array is the value
	# of the 'post_id' field in the YAML data in the comments files.
	def self.read_comments(source)
		comments = Hash.new() { |h, k| h[k] = Array.new }
		
		Dir["#{source}/**/_comments/**/*"].sort.each do |comment|
			next unless File.file?(comment) and File.readable?(comment)
			yaml_data = YAML::load_file(comment)
			post_id = yaml_data.delete('post_id')
			comments[post_id] << yaml_data
		end
		
		comments
	end
end
end
