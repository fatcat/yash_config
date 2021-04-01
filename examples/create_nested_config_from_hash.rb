#!/usr/bin/ruby
require 'tmpdir'
require 'yash_config'
#require_relative '../lib/yash_config'

tmpdir = Dir.mktmpdir
puts "Using #{tmpdir} for file creation"

config_file = "#{tmpdir}/yash_config.yaml"

puts "Initialize with hash"
config = YashConfig.new({ 
	:config_file => config_file,
	:string_value => 'zero',
	:integer_value => 0,
	:nested => {:nested_val1 => 'thing1', :nested_val2 => 'thing2' },
	:boolean_value => true
})

puts
puts "Content of config object"
config.each do |key,value|
	puts "#{key} => #{value}"
end
puts
puts "Content of config file"
puts File.open(config[:config_file]).readlines
puts
