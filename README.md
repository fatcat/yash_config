# yash_config

yash_config allows simple creation and management of configuration files. "yash" is a portmanteau of YAML and Hash, as those are the underlying storage and manipulation mechanisms, respectively. i

The yaml store actually uses Ruby's native 'pstore' capability, so yash_config has no dependencies outside Ruby's standard library.

yash_config's overriding concern is brain-dead simplicity, not feature exhaustion. If you need to keep a simple, persistent configuration for a Ruby script but want the learning curve to be negligible yash_config is what you want. If you understand Ruby hashes then you understand yash_config.

Instantiate a yash_config object with a Hash and a matching yaml file is created at the location you specify. Then use hash-like syntax to add, change and delete keys and values from the configuration. Each time you change the config it is synchronously written to disk. The yaml configuration file can be edited by hand and read back into a yash_config object. 

One of the more important changes to V3 is that it now resembles more a `Hash` style interface. You can use `[]`, `fetch`, `each`, etc... Actually the hash notation is a bit more robust since the dot notation won't work for a few property names (a few public methods from `Configatron::Store` itself).

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




