#!/usr/bin/ruby
require 'yash_config'
#require_relative '../lib/yash_config'

config_file = "example_config.yaml"

puts "Initialize from file"
config = YashConfig.new({ :config_file => config_file })
puts "Content of config object"
config.each do |key,value|
	puts "#{key} => #{value}"
end
puts
puts "Content of config file"
puts File.open(config[:config_file]).readlines
puts
