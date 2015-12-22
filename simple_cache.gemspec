# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_cache"
  spec.version       = SimpleCache::VERSION
  spec.authors       = ["Tatsuro Mitsuno"]
  spec.email         = ["c.arabica.l@gmail.com"]

  spec.summary       = %q{cache module}
  spec.description   = %q{SimpleCache is a cache module based on LRU}
  spec.homepage      = "https://github.com/kotatsu360/simple-cache"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
