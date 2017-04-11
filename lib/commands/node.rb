require 'thor'

module Jenkins2API
  module Command
    class Node < Jenkins2API::ThorCommand
      desc :all, "List all nodes"
      def all
        nodes = client.node.all
        nodes['computer'].each do |computer|
          type = 'slave'
          type = 'master' if computer['_class'] == 'hudson.model.Hudson$MasterComputer'
          puts "[%5s] #{computer['displayName']}" % [type]
        end
      end

      desc :slaves, "List all slave nodes"
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


