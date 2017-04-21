$:.push File.expand_path("../lib", __FILE__)
require_relative 'lib/version'

Gem::Specification.new do |s|
  s.name = 'jenkins2-api'
  s.version = Jenkins2API::VERSION
  s.summary = 'API client for Jenkins 2.'
  s.description = 'API client for Jenkins 2 with executable'
  s.authors = ['Balazs Nadasdi']
  s.email = 'balazs.nadasdi@cheppers.com'
  s.homepage = 'https://yitsushi.github.io/jenkins2-api/'
  s.license = 'MIT'

  s.required_ruby_version = ::Gem::Requirement.new('~> 1.9')

  s.files = Dir['CHANGELOG.md', 'LICENSE', 'README.md', 'lib/**/*.rb']
  s.executables = ['jenkins2api']
  s.test_files = Dir['spec/**/*']

  s.require_path = 'lib'

  s.add_dependency 'thor', '~> 0.19'

  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rdoc', '~> 5.1'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'webmock', '~> 3.0'
  s.add_development_dependency 'sinatra', '~> 1.4'
  s.add_development_dependency 'rubocop', '~> 0.48'
end

