require_relative 'base_endpoint'

module Jenkins2API
  module Endpoint
    # This class contains all the calls to reach
    # Jenkins2 and obtain Build data
    class Job < BaseEndpoint
      # Lists all available jobs
      def list
        @client.api_request(:get, "")['jobs']
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
    end
  end
end

