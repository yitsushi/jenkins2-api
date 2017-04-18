module Jenkins2API
  # Module to wrap all the endpoint
  module Endpoint
    # General methods for endpoints
    class BaseEndpoint
      # Stores the Jenkins2API::Client instance
      def initialize(client)
        @client = client
      end
    end
  end
end
