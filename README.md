# yash_config

yash_config allows simple creation and management of configuration files. "yash" is a portmanteau of YAML and Hash, as those are the underlying storage and manipulation mechanisms, respectively. 

yash_config's overriding concern is brain-dead simplicity, not feature exhaustion. If you need to keep a simple, persistent configuration for a Ruby script but want a negligible learning curve yash_config is what you want. If you understand Ruby hashes then you understand yash_config.

You can instantiate a yash_config object with a Hash or with a yaml file. If you instantiate with a hash a matching yaml file is created at the location you specify.

Once you have a yash_config object then you simply use hash-like syntax to read, add, change and delete keys and values from the configuration. Each time you change the config it is synchronously written to disk. The file can be edited by hand and read back into a yash_config object. 

Integrating Ruby's [OptParse](https://github.com/ruby/optparse) library for command line option handling is easy. See the examples.

## Installation

```bash
$ git clone https://github.com/fatcat/yash_config.git
$ gem build yash_config.gemspec
$ gem install yash_config
```

## Usage

Require yash_config to use it:

```ruby
require 'yash_config'
```

### Instantiation

If the config file you specify exists and is a yaml file, it will be read into the yash_config object. If the file does not exist it will be created.

***NOTE:*** You must instantiate a YashConfig object with the ':config_file' key.

```ruby
config = YashConfig.new({:config_file => '/tmp/yash_config.yaml'})
```

### Making changes

Adding a value to the config can be done during instantiation:

```ruby
config = YashConfig.new({:config_file => '/tmp/yash_config.yaml', :param => 'some value'})
```

or to the yash_config object directly:

```ruby
config = YashConfig.new({:config_file => '/tmp/yash_config.yaml'})
config[:param] = 'some value'
```

The resulting YAML file looks like this:

```yaml
---
:config_file: /tmp/yash_config.yaml
:param: some value
```

### Other methods

```ruby
YashConfig.delete(key)
YashConfig.each
YashConfig.clear_configuration
YashConfig.to_h
```




