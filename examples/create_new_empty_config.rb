#!/usr/bin/ruby
require 'tmpdir'
require 'yash_config'
#require_relative '../lib/yash_config'

tmpdir = Dir.mktmpdir
puts "Using #{tmpdir} for file creation"

config_file = "#{tmpdir}/yash_empty_config.yaml"

puts "Initialize empty configuration"
config = YashConfig.new({ :config_file => config_file })

puts "Content of config object"
config.each do |key,value|
        puts "#{key} => #{value}"
end
puts
puts "Content of config file"
puts File.open(config[:config_file]).readlines
puts

