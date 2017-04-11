$:.push File.expand_path("../lib", __FILE__)
require_relative 'lib/version'

Gem::Specification.new do |s|
  s.name = 'jenkins2-api'
  s.version = Jenkins2API::VERSION
  s.date = '2017-04-06'
  s.summary = 'API client for Jenkins 2.'
  s.description = 'API client for Jenkins 2 with executable'
  s.authors = ['Balazs Nadasdi']
  s.email = 'balazs.nadasdi@cheppers.com'
  s.homepage = 'https://github.com/Yitsushi/jenkins2-api'
  s.license = 'MIT'

  s.required_ruby_version = '~> 2.0'

  s.files = Dir['CHANGELOG.md', 'LICENSE', 'README.md', 'lib/**/*.rb']
  s.executables = ['jenkins2api']

  s.require_path = 'lib'

  s.add_dependency 'thor', '~> 0.19'
end

