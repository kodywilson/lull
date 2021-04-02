# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'lull'
  s.version       = '0.0.0'
  s.summary       = 'Rest helper'
  s.description   = 'A simple wrapper for rest-client'
  s.authors       = ['Kody Wilson']
  s.email         = 'kodywilson@gmail.com'
  s.files         = ['lib/lull.rb']
  s.homepage      = 'https://github.com/kodywilson/lull'
  s.license       = 'MIT'
  s.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  # Dependencies
  s.add_runtime_dependency 'rest-client', '~> 2.1.0', '>= 2.1.0'
end
