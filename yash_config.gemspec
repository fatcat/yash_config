Gem::Specification.new do |s|
  s.name = %q{yash_config}
  s.version = "1.0.0"
  s.date = %q{2018-11-25}
  s.summary = %q{Extremely simple library to create and manage configuration files.}
  s.description = %q{ yash_config allows simple creation and management of configuration files. "yash" is a portmanteau of YAML and Hash, as those are the underlying storage and manipulation mechanisms, respectively. 

yash_config's overriding concern is brain-dead simplicity, not feature exhaustion. If you need to keep a simple, persistent configuration for a Ruby script but want the learning curve to be negligible yash_config is what you want. If you understand Ruby hashes then you understand yash_config.

Instantiate a yash_config object with a Hash and a matching yaml file is created at the location you specify. Then use hash-like syntax to add, change and delete keys and values from the configuration. Each time you change the config it is synchronously written to disk. The file can be edited by hand and read back into a yash_config object. 
}
  s.files = [
    "lib/yash_config.rb"
  ]
  s.authors     = ["Daniel L. McNulty"]
  s.license       = 'BSD'
  s.require_paths = ["lib"]
end
