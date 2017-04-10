module Jenkins2API
  class Build
    def initialize(client)
      @client = client
    end

    def get(job_name, build_id)
      @client.api_request(:get, "/job/#{job_name}/#{build_id}")
    end

    def latest(name)
      @client.api_request(:get, "/job/#{name}/lastBuild")
    end

    def test_results(name, build_id)
      @client.api_request(:get, "/job/#{name}/#{build_id}/testReport")
    end

    def logtext_lines(name, build_id)
      @client.api_request(:get, "/job/#{name}/#{build_id}/logText/progressiveText", :raw).split("\r\n")
    end

    def slave_name(name, build_id)
      log = logtext_lines(name, build_id)
      relevant_line = log.select { |line| line.match(/^Running on /) }.first

      relevant_line.match(/^Running on (.*) in \//)[1]
    end
  end
end
