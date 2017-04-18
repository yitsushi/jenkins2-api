require_relative 'base_endpoint'

module Jenkins2API
  module Endpoint
    # This class contains all the calls to reach
    # Jenkins2 and obtain Computer data
    class Node < BaseEndpoint
      # List all available Computer
      #
      # Returns with slaves and masters also
      def all
        @client.api_request(:get, "/computer")
      end
    end
  end
end

