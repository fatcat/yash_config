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

	def test_each
		config_filename = 'each_test.yaml'
		FileUtils.rm config_filename unless !File.exist? config_filename
		config = YashConfig.new({
			:config_file => config_filename,
			:param1 => 'value1',
			:param2 => 'value2'
		})

		keys = []
		values = []
		config.each do |key, value|
			keys << key
			values << value
		end

		assert keys.include?(:config_file)
		assert keys.include?(:param1)
		assert keys.include?(:param2)
		assert values.include?(config_filename)
		assert values.include?('value1')
		assert values.include?('value2')
	end

	def test_clear_configuration
		config_filename = 'clear_test.yaml'
		FileUtils.rm config_filename unless !File.exist? config_filename
		config = YashConfig.new({
			:config_file => config_filename,
			:param1 => 'value1',
			:param2 => 'value2'
		})

		# verify params exist before clear
		assert config[:param1] == 'value1'
		assert config[:param2] == 'value2'

		config.clear_configuration

		# params should be gone
		assert config[:param1] == nil
		assert config[:param2] == nil

		# config_file should still exist
		assert config[:config_file] == config_filename
	end

	def test_to_h
		config_filename = 'to_h_test.yaml'
		FileUtils.rm config_filename unless !File.exist? config_filename
		config = YashConfig.new({
			:config_file => config_filename,
			:param1 => 'value1',
			:param2 => 'value2'
		})

		hash = config.to_h

		assert hash.instance_of?(Hash)
		assert hash[:config_file] == config_filename
		assert hash[:param1] == 'value1'
		assert hash[:param2] == 'value2'
	end

	def test_data_types_string
		config_filename = 'types_string.yaml'
		FileUtils.rm config_filename unless !File.exist? config_filename
		config = YashConfig.new({
			:config_file => config_filename,
			:empty_string => '',
			:simple_string => 'hello',
			:string_with_spaces => 'hello world',
			:string_with_special => 'special: chars! @#$%'
		})

		assert config[:empty_string] == ''
		assert config[:simple_string] == 'hello'
		assert config[:string_with_spaces] == 'hello world'
		assert config[:string_with_special] == 'special: chars! @#$%'
	end

	def test_data_types_integer
		config_filename = 'types_integer.yaml'
		FileUtils.rm config_filename unless !File.exist? config_filename
		config = YashConfig.new({
			:config_file => config_filename,
			:zero => 0,
			:positive => 42,
			:negative => -17,
			:large => 1000000
		})

		assert config[:zero] == 0
		assert config[:positive] == 42
		assert config[:negative] == -17
		assert config[:large] == 1000000

		# verify they are actually integers
		assert config[:zero].instance_of?(Integer)
		assert config[:positive].instance_of?(Integer)
		assert config[:negative].instance_of?(Integer)
	end

	def test_data_types_boolean
		config_filename = 'types_boolean.yaml'
		FileUtils.rm config_filename unless !File.exist? config_filename
		config = YashConfig.new({
			:config_file => config_filename,
			:flag_true => true,
			:flag_false => false
		})

		assert config[:flag_true] == true
		assert config[:flag_false] == false

		# verify they are actually booleans
		assert config[:flag_true].instance_of?(TrueClass)
		assert config[:flag_false].instance_of?(FalseClass)
	end

	def test_persistence_across_reinstantiation
		config_filename = 'persistence_test.yaml'
		FileUtils.rm config_filename unless !File.exist? config_filename

		# create config with values
		config = YashConfig.new({
			:config_file => config_filename,
			:string_val => 'persisted string',
			:int_val => 123,
			:bool_val => true
		})

		# verify initial values
		assert config[:string_val] == 'persisted string'
		assert config[:int_val] == 123
		assert config[:bool_val] == true

		# create a new instance from the same file
		config2 = YashConfig.new({ :config_file => config_filename })

		# verify values persisted
		assert config2[:string_val] == 'persisted string'
		assert config2[:int_val] == 123
		assert config2[:bool_val] == true

		# modify value in second instance
		config2[:new_param] = 'added later'

		# create a third instance and verify all values
		config3 = YashConfig.new({ :config_file => config_filename })
		assert config3[:string_val] == 'persisted string'
		assert config3[:int_val] == 123
		assert config3[:bool_val] == true
		assert config3[:new_param] == 'added later'
	end

	def test_directory_auto_creation
		# use a nested directory that doesn't exist
		nested_dir = 'auto_created/nested/path'
		config_filename = "#{nested_dir}/config.yaml"

		# clean up if exists from previous run
		FileUtils.rm_rf 'auto_created' if File.directory? 'auto_created'

		# verify directory doesn't exist
		assert !File.directory?(nested_dir)

		config = YashConfig.new({
			:config_file => config_filename,
			:param => 'value'
		})

		# verify directory and file were created
		assert File.directory?(nested_dir)
		assert File.exist?(config_filename)
		assert config[:param] == 'value'

		# clean up
		FileUtils.rm_rf 'auto_created'
	end

	def test_error_empty_config_file
		assert_raises(RuntimeError) do
			YashConfig.new({ :config_file => '' })
		end
	end

	def test_error_nil_config_file
		assert_raises(RuntimeError) do
			YashConfig.new({ :config_file => nil })
		end
	end

	def test_error_integer_config_file
		assert_raises(RuntimeError) do
			YashConfig.new({ :config_file => 12345 })
		end
	end

	def test_error_non_hash_options
		assert_raises(RuntimeError) do
			YashConfig.new("not a hash")
		end
	end

	def test_error_delete_config_file_key
		config_filename = 'delete_key_test.yaml'
		FileUtils.rm config_filename unless !File.exist? config_filename
		config = YashConfig.new({
			:config_file => config_filename,
			:param => 'value'
		})

		assert_raises(RuntimeError) do
			config.delete(:config_file)
		end
	end

end

