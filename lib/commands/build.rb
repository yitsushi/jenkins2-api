require 'thor'

module Jenkins2API
  # Command module wraps all the cli commands
  module Command
    # Contains all the commands under +build+ namespace
    class Build < Jenkins2API::ThorCommand
      desc 'slave-name JOB_NAME BUILD_ID', 'Get Node name for a specific build'
      method_option :ec2id, default: false, type: :boolean
      # Displays the name of the slave where the build was executed
      def slave_name(name, build_id)
        slave_name = client.build.slave_name(name, build_id)
        if options[:ec2id]
          slave_name = slave_name.match(/(i-[0-9a-zA-Z]+)/)
                                 .captures
                                 .first
        end

        puts slave_name
      end

      desc 'logs JOB_NAME BUILD_ID', 'Get the logs for a specific build'
      # Retrieve logs for a specific job and join them by newline
      def logs(name, build_id)
        puts client.build.logtext_lines(name, build_id).join("\n")
      end
    end
  end
end
