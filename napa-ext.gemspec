# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'napa/ext/version'

Gem::Specification.new do |spec|
  spec.name          = 'napa-ext'
  spec.version       = Napa::Ext::VERSION
  spec.authors       = ['soloman']
  spec.email         = ['soloman1124@gmail.com']
  spec.summary       = 'Some additional Napa middlewares'
  spec.description   = 'Some additional Napa middlewares'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rack', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'rubocop', '~> 0.27'
end
