require 'minitest/autorun'
require 'yash_config'

Dir.chdir 'test'

class YashConfigTest < Minitest::Test

	def test_initialize_from_hash
		config_filename = 'from_hash.yaml'
  	FileUtils.rm config_filename unless !File.exist? config_filename
		config = YashConfig.new({
  		:config_file => config_filename,
  		:test_parameter => 'test_value'
		})
		assert config[:config_file] == config_filename
		assert config[:test_parameter] == 'test_value'
		assert File.exist? config_filename
	end

	def test_initialize_from_file
		config_filename = 'from_file.yaml'
		config = YashConfig.new({ :config_file => config_filename })
		assert config[:config_file] == config_filename
	end

	def test_add_del_change
		config_filename = 'from_file.yaml'
		config = YashConfig.new({
  		:config_file => config_filename
		})

		# :test_parameter should not exist
		assert config[:test_parameter] == nil

		# add :test_parameter with a value
		config[:test_parameter] = 'test_value'
		assert config[:test_parameter] == 'test_value'

		# change :test_parameter value
		config[:test_parameter] = 'different_test_value'
		assert config[:test_parameter] == 'different_test_value'

		# delete :test_parameter
		config.delete(:test_parameter)
		assert config[:test_parameter] == nil
	end
	
end

