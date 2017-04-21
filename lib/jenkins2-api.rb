unless Kernel.respond_to?(:require_relative)
  # Extend base module because
  module Kernel
    # Ruby 1.9 does not support require relative :/
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'version'
require_relative 'client'
require_relative 'thor_command'

path = File.join(File.dirname(__FILE__), 'commands', '*.rb')
Dir.glob(path).each do |file|
  require file
end
