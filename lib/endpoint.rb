module Jenkins2API
  # General methods for endpoints
  class Endpoint
    # Stores the Jenkins2API::Client instance
    def initialize(client)
      @client = client
    end
  end
end
