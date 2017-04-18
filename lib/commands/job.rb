require 'thor'

module Jenkins2API
  # Command module wraps all the cli commands
  module Command
    # Contains all the commands under +job+ namespace
    class Job < Jenkins2API::ThorCommand
    end
  end
end
