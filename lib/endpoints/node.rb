module Jenkins2API
  # This class contains all the calls to reach
  # Jenkins2 and obtain Computer data
  class Node
    # Stores the Jenkins2API::Client instance
    def initialize(client)
      @client = client
    end

    # List all available Computer
    #
    # Returns with slaves and masters also
    def all
      @client.api_request(:get, "/computer")
    end
  end
end

