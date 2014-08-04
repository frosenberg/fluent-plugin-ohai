# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-ohai"
  spec.version       = "0.0.1"
  spec.authors       = ["Florian Rosenberg"]
  spec.email         = ["f.rosenberg@gmail.com"]
  spec.summary       = %q{Plugin for fluentd to read data from ohai.}
  spec.description   = %q{The plugin reads ohai data from the system and emits it to fluentd. It can be configured to re-run at a certain interval.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
