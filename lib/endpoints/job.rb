require_relative 'base_endpoint'

module Jenkins2API
  module Endpoint
    # This class contains all the calls to reach
    # Jenkins2 and obtain Build data
    class Job < BaseEndpoint
      # Lists all available jobs
      def list
        @client.api_request(:get, '')['jobs']
      end

      # Get test results "alias"
      # Why? Because jenkins1 api gem uses this logic
      # Why? I don't know.
      #
      # ==== Params:
      # +name+:: Name of the Job
      # +build_id+:: ID of the build
      def get_test_results(name, build_id)
        @client.build.test_results(name, build_id)
      end

      # Get all available builds for a specific job
      #
      # ==== Params:
      # +name+:: Name of the Job
      #
      # Returns with an array of builds
      def builds(name)
        @client.api_request(:get, "/job/#{name}")['builds']
      end

      # Get all available sub-jobs for a specific job
      #
      # ==== Params:
      # +name+:: Name of the Job
      #
      # Returns with an array of jobs
      def jobs(name)
        @client.api_request(:get, "/job/#{name}")['jobs']
      end

      # Trigger a build on a specific job
      #
      # ==== Params:
      # +name+:: Name of the job
      # +parameters+:: Hash with build parameters,
      #   key => valule pairs
      # +delay+:: Delay the build in seconds
      def build(name, parameters = {}, delay = 0)
        post = { parameter: [] }
        parameters.each do |key, value|
          post[:parameter] << { name: key, value: value }
        end

        @client.api_request(
          :post,
          "/job/#{name}/build?delay=#{delay}sec",
          :raw,
          json: post.to_json
        )
      end

      # Compatibility with jenkins-api gem (for Jenkins1)
      alias get_builds builds
    end
  end
end
