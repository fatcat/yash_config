#!/usr/bin/ruby

#require 'yash_config'
require_relative '../lib/yash_config'

config_file = "#{ENV['HOME']}/yash_config.yaml"

config = YashConfig.new({ 
		:config_file => config_file,
   	:string_value => 'zero',
   	:integer_value => 0,
   	:boolean_value => true
	})

config.each do |key, value|
	puts "#{key} #{value}"
end

puts File.open(config[:config_file]).readlines
puts "Original value: " + config[:string_value]
config[:string_value] = 'one'
puts "Changed value: " + config[:string_value]
puts
puts "Add a new configuration parameter"
config[:new_param] = 'new'
puts File.open(config[:config_file]).readlines
puts
puts "Clear configuration"
config.clear_configuration
puts File.open(config[:config_file]).readlines
puts
puts "Change filename"
config[:config_file] = "#{ENV['HOME']}/new-config.yaml"
puts File.open(config[:config_file]).readlines
