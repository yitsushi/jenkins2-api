module Jenkins2API
  class Artifact
    def initialize(client)
      @client = client
    end

    def all(name, build_id)
      @client.build.get(name)['artifacts']
    end

    def get(name, build_id, artifact)
      @client.api_request(:get, "/job/#{name}/#{build_id}/artifact/#{artifact['relativePath']}", :raw)
    end
  end
end
