require_relative 'version'
require_relative 'client'
require_relative 'thor_command'

path = File.join(File.dirname(__FILE__), 'commands', '*.rb')
Dir.glob(path).each do |file|
  require file
end
