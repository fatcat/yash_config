#!/usr/bin/ruby
require 'tmpdir'
require 'yash_config'
#require_relative '../lib/yash_config'

tmpdir = Dir.mktmpdir
puts "Using #{tmpdir} for file creation"

config_file = "#{tmpdir}/yash_config.yaml"

config = YashConfig.new({ 
	:config_file => config_file,
	:string_value => 'zero',
	:integer_value => 0,
	:boolean_value => true
})

puts "Reference a config value: #{config[:string_value]}"
