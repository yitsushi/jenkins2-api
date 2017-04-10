module Jenkins2API
  class Job
    def initialize(client)
      @client = client
    end

    def list
      @client.api_request(:get, "")['jobs']
    end

    def builds(name)
      @client.api_request(:get, "/job/#{name}")['builds']
    end
  end
end

