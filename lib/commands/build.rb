require 'thor'

module Jenkins2API
  module Command
    class Build < Jenkins2API::ThorCommand
      desc 'slave-name JOB_NAME BUILD_ID', 'Get Node name where a specific build was running'
      method_option :ec2id, :default => false, :type => :boolean
      def slave_name(name, build_id)
        slave_name = client.build.slave_name(name, build_id)
        slave_name = slave_name.match(/(i-[0-9a-zA-Z]+)/).captures.first if options[:ec2id]

        puts slave_name
      end
    end
  end
end
