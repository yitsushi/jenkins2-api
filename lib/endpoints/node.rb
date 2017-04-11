module Jenkins2API
  class Node
    def initialize(client)
      @client = client
    end

    def all
      @client.api_request(:get, "/computer")
    end
  end
end

