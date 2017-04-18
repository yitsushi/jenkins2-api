require 'thor'

module Jenkins2API
  # Command module wraps all the cli commands
  module Command
    # Contains all the commands under +node+ namespace
    class Node < Jenkins2API::ThorCommand
      # Jenkins java class of the master instance
      MASTER_CLASS = 'hudson.model.Hudson$MasterComputer'.freeze

      desc :all, 'List all nodes'
      # List all available nodes
      def all
        nodes = client.node.all
        nodes['computer'].each do |computer|
          type = 'slave'
          type = 'master' if computer['_class'] == MASTER_CLASS
          printf("[%6s] %s\n", type, computer['displayName'])
        end
      end

      desc :slaves, 'List all slave nodes'
      # List all avilable slaves
      def slaves
        nodes = client.node.all
        nodes['computer'].each do |computer|
          next if computer['_class'] == MASTER_CLASS
          puts computer['displayName']
        end
      end
    end
  end
end
