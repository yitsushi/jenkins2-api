module Jenkins2API
  # This class contains all the calls to reach
  # Jenkins2 and obtain Build data
  class Job
    # Stores the Jenkins2API::Client instance
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

