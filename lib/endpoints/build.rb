module Jenkins2API
  # This class contains all the calls to reach
  # Jenkins2 and obtain Build data
  class Build
    # Stores the Jenkins2API::Client instance
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

      name = relevant_line.match(/^Running on (.*) in \//).captures.first rescue nil

      if name.nil?
        relevant_line = log.select { |line| line.match(/Building remotely on/) }.first
        name = relevant_line.match(/Building remotely on (.*) in workspace/).captures.first
      end

      name
    end
  end
end
