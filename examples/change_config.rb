#!/usr/bin/ruby
require 'tmpdir'
require 'yash_config'
#require_relative '../lib/yash_config'

tmpdir = Dir.mktmpdir
puts "Using #{tmpdir} for file creation"

config_file = "#{tmpdir}/yash_config.yaml"
new_config_file = "#{tmpdir}/new-config.yaml"

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
config[:string_value] = 'cat and mouse'
puts "New value: " + config[:string_value]
puts File.open(config[:config_file]).readlines
puts
puts "Add a new configuration parameter"
config[:new_param] = 'I\'m new!'
puts File.open(config[:config_file]).readlines
puts
puts "Delete configuration parameter"
config.delete(:new_param)
puts File.open(config[:config_file]).readlines
puts
puts
puts "Clear configuration"
config.clear_configuration
puts File.open(config[:config_file]).readlines
puts

