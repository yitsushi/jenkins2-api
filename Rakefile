require 'rubygems/package_task'
require 'rubygems/dependency_installer'
require 'rdoc/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

namespace :gem do
  specfile = 'jenkins2-api.gemspec'

  Gem::PackageTask.new(Gem::Specification.load(specfile)) {}

  desc 'Install this gem locally'
  task :install, [:user_install] => :gem do |t, args|
    args.with_defaults( user_install: false )
    Gem::Installer.new("pkg/jenkins2-api-#{Jenkins2API::VERSION}.gem", user_install: args.user_install).install
  end
end

namespace :dependencies do
  desc 'Install development dependencies'
  task :install do |t|
    installer = Gem::Installer.new('')
    unsatisfied_dependencies = Gem::Specification.load(specfile).development_dependencies.select do |dp|
      !installer.installation_satisfies_dependency?(dp)
    end
    next if unsatisfied_dependencies.empty?
    unsatisfied_dependencies.each do |dp|
      Gem::DependencyInstaller.new( user_install: ENV['RUBY_ENV'] == 'citest' ).install(dp)
    end
  end
end

namespace :doc do
  desc 'generate API documentation'
  Rake::RDocTask.new do |rd|
    rd.rdoc_dir = 'doc'
    rd.main = 'README.md'
    rd.rdoc_files.include(
      'README.md',
      'LICENSE',
      "bin/**/*\.rb",
      "lib/**/*\.rb"
    )
    rd.options << '--line-numbers'
    rd.options << '--all'
  end
end

namespace :test do
  RuboCop::RakeTask.new(:rubocop)
  RSpec::Core::RakeTask.new(:spec)
end

task default: ['test:rubocop', 'test:spec']
