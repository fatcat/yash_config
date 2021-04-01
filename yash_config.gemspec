Gem::Specification.new do |s|
  s.name = %q{yash_config}
  s.version = "1.1.0"
  s.date = %q{2021-04-02}
  s.summary = %q{Extremely simple library to create and manage configuration files.}
  s.description = %q{ yash_config allows simple creation and management of configuration files. "yash" is a portmanteau of YAML and Hash, as those are the underlying storage and manipulation mechanisms, respectively. 

yash_config's overriding concern is brain-dead simplicity, not feature exhaustion. If you need to keep a simple, persistent configuration for a Ruby script but want a negligible learning curve yash_config is what you want. If you understand Ruby hashes then you understand yash_config.

You can instantiate a yash_config object with a Hash or with a yaml file. If you instantiate with a hash a matching yaml file is created at the location you specify.

Once you have a yash_config object then you simply use hash-like syntax to add, change and delete keys and values from the configuration. Each time you change the config it is synchronously written to disk. The file can be edited by hand and read back into a yash_config object. 
}
  s.files = [
    "lib/yash_config.rb"
  ]
  s.authors     = ["Daniel L. McNulty"]
  s.license       = 'BSD-3-Clause'
  s.require_paths = ["lib"]
end
