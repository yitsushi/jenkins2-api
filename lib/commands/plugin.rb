require 'thor'

module Jenkins2API
  # Command module wraps all the cli commands
  module Command
    # Contains all the commands under +plugin+ namespace
    class Plugin < Jenkins2API::ThorCommand
      desc 'list', 'List plugins'
      # List installed plugins
      def list
        puts "Legend:\n  I  Inactive\n  U  Update is available\n"

        client.configuration.plugin_list.each do |plugin|
          flag = ' '
          flag = 'I' unless plugin['active']
          flag = 'U' if plugin['hasUpdate']

          printf(
            " [%s] %s (%s@%s)\n", flag, plugin['longName'],
            plugin['shortName'], plugin['version']
          )
        end
      end

      desc 'install PLUGIN_NAME PLUGIN_ID', 'Install a specific plugin'
      # Install a plugin
      def install(name, id)
        client.configuration.plugin_install(name, id)
      end
    end
  end
end
