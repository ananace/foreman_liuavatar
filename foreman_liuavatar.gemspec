# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foreman_liuavatar/version'

Gem::Specification.new do |spec|
  spec.name          = 'foreman_liuavatar'
  spec.version       = ForemanLiuavatar::VERSION
  spec.authors       = ['Alexander Olofsson']
  spec.email         = ['alexander.olofsson@liu.se']

  spec.summary       = 'Handles LiU employee avatars'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ananace/foreman_liuavatar'
  spec.license       = 'GPL-3.0'

  spec.required_ruby_version = '>= 2.5.0'

  spec.files         = Dir['{app,lib}/**/*.{rake,rb}'] + %w[LICENSE.txt README.md]
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
