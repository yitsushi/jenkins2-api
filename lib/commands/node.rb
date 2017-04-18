require 'thor'

module Jenkins2API
  # Command module wraps all the cli commands
  module Command
    # Contains all the commands under +node+ namespace
    class Node < Jenkins2API::ThorCommand

      desc :all, "List all nodes"
      # List all available nodes
      def all
        nodes = client.node.all
        nodes['computer'].each do |computer|
          type = 'slave'
          type = 'master' if computer['_class'] == 'hudson.model.Hudson$MasterComputer'
          puts "[%5s] #{computer['displayName']}" % [type]
        end
      end

      desc :slaves, "List all slave nodes"
      # List all avilable slaves
      def slaves
        nodes = client.node.all
        nodes['computer'].each do |computer|
          next if computer['_class'] == 'hudson.model.Hudson$MasterComputer'
          puts computer['displayName']
        end
      end
    end
  end
end


