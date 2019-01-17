#!/usr/bin/ruby

#require 'yash_config'
require_relative '../lib/yash_config'

config_file = "#{ENV['HOME']}/yash_config.yaml"
new_config_file = "#{ENV['HOME']}/new-config.yaml"

puts "Initialize"
config = YashConfig.new({ 
		:config_file => config_file,
   	:string_value => 'zero',
   	:integer_value => 0,
   	:boolean_value => true
	})
puts File.open(config[:config_file]).readlines
puts
puts "Change values"
puts "Original value: " + config[:string_value]
config[:string_value] = 'one'
puts "Changed value: " + config[:string_value]
puts File.open(config[:config_file]).readlines
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
config[:config_file] = new_config_file
puts File.open(config[:config_file]).readlines

#FileUtils.rm(new_config_file)
