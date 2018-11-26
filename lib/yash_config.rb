require 'yaml/store'
require 'fileutils'

class YashConfig
	include Enumerable

	def initialize(options)
		@config = options if sanity_check(options)
	
		if config_file_exists? then
			existing_config = open_config_file
			@config.merge!(existing_config)
			write_config
		else
			create_config_file
			write_config
		end
	end

	def [](key)
		@config[key]
	end

	def []=(key, value)
		begin
			FileUtils.mv(@config[:config_file], value) if key == :config_file
		rescue Errno::EACCES
			raise Errno::EACCES
		end
		@config[key] = value
		write_config
	end

	def each
		@config.each do |obj|
			yield obj
		end
	end

	def delete(key)
		raise "you cannot delete the key \":config_file\"" if key == :config_file
		@config.delete(key)
		write_config
	end

	def clear_configuration
		config_file = @config[:config_file]
		@config = Hash.new
		@config.merge!({:config_file => config_file})
		write_config
	end

	def to_h
		@config	
	end

private

	def read_config
		config = {}
		begin
			config_s = YAML::Store.new(@config[:config_file])
			config_s.transaction do
				config_s.roots.each do |root|
        			config[root] = config_s[root]
				end
			end
		rescue PStore::Error
			puts "#{@config[:config_file]} is not in yaml format"
			raise PStore::Error
		end
		config
	end

	def write_config
		File.delete(@config[:config_file])
		config_s = YAML::Store.new(@config[:config_file])
		@config.each do |key, val|
			config_s.transaction do
         	config_s[key] = val
				config_s.commit
      	end  
		end
	end

	def config_file_exists?
		File.exists?(@config[:config_file])	
	end

	def create_config_file_path(dir)
		begin
			FileUtils.mkdir_p(dir)
		rescue Errno::EACCES
			raise Errno::EACCES
		end
	end

	def create_config_file
		dir = File.dirname(@config[:config_file])
		begin	
			if !File.directory?(dir) 
				create_config_file_path(dir)
			end
			File.new(@config[:config_file], "w")
		rescue Errno::EACCES
			puts "Cannot create file: \"#{@config[:config_file]}\", no permission"
			raise Errno::EACCES
		end
	end

	def open_config_file
		config = read_config
		@config.merge!(config)
	end

	def sanity_check(options)
		if !options.instance_of?(Hash)
			raise "Options must be a Hash object"
		elsif options[:config_file] == nil
			raise "Configuration filename must be supplied: Configuration.new({:config_file => \"path/to/file\"})"
		elsif Gem.win_platform?
			raise "This library is not tested on Windows and probably won't work"
		elsif Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.0.0')
			raise "This library will not work on Ruby versions prior to 2.0.0"
		else
			true
		end
	end

end
