require 'optparse'
require 'yash_config'

# Its very easy to use OptParse in conjunction with YashConfig
# Use OptParse as usual but force OptParse to produce a Hash, then
# just initialize YashConfig with the Hash OptParse produces

options = {:debug => false, :flag => false}

opt_parser = OptionParser.new do |opts|
	opts.banner = "Usage: with_parse.rb [options]"
		
  	opts.on("-c", "--config_file CONFIG_FILE", "Configuration file") do |c|
  		options[:config_file] = c
  	end

  	opts.on("-f", "--flag", "A flag, if set it will resolve to \"true\"") do |f|
  		options[:flag] = f
  	end
  	
		opts.on("-i", "--integer integer", Integer, "An integer parameter") do |i|
			if !i.integer? then raise "Argument to parameter \"-i\" must be an integer" end
  		options[:integer] = i
  	end

		opts.on("-s", "--string string", "A string parameter") do |s|
  		options[:string] = s
  	end

  	opts.on("-d", "--debug", "Turn on debugging") do |d|
  		options[:debug] = d
  	end

  	opts.on("-h", "-?", "--help", "Prints this help") do
  		puts opts
  		exit
  	end

end.parse!(into: {})   # Force OptParse to produce a Hash

if !options.has_key?(:config_file) then
	raise "Must specify a filename: (-c <filename>)"
end

p "Options: " + options.to_s if options[:debug]

config = YashConfig.new(options)
p config
