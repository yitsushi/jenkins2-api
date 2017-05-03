require 'thor'

module Jenkins2API
  # Command module wraps all the cli commands
  module Command
    # Contains all the commands under +job+ namespace
    class Job < Jenkins2API::ThorCommand
      desc 'build JOB_NAME', 'Start a build for a specific job'
      method_option :params, default: {}, type: :hash
      method_option :delay, default: 0, type: :numeric
      # Start a build
      def build(name)
        client.job.build(name, options[:params], options[:delay])
      end
    end
  end
end
