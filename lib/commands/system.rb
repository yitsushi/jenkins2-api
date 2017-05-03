require 'thor'

module Jenkins2API
  # Command module wraps all the cli commands
  module Command
    # Contains all the commands under +system+ namespace
    class System < Jenkins2API::ThorCommand
      desc 'safe-restart', 'Restart jenkins in safe mode'
      # Install a plugin
      def safe_restart
        client.configuration.safe_restart
      end
    end
  end
end
