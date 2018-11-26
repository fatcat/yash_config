require 'minitest/autorun'
require 'simple_configuration'

class SimpleConfigurationTest < Minitest::Test
	def setup
		@config = SimpleConfiguration.new({:config_file => "/dev/null"})
	end
end
