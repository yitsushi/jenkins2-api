require_relative '../endpoint'

module Jenkins2API
  # This class contains all the calls to reach
  # Jenkins2 and obtain Build data
  class Build < Endpoint
    # Get a specific build
    #
    # ==== Params:
    # +job_name+:: Name of the Job
    # +build_id+:: ID of the build
    def get(job_name, build_id)
      @client.api_request(:get, "/job/#{job_name}/#{build_id}")
    end

    # Get the latest build
    #
    # ==== Params:
    # +job_name+:: Name of the Job
    def latest(name)
      @client.api_request(:get, "/job/#{name}/lastBuild")
    end

    # Get test report for a specific build
    #
    # ==== Params:
    # +name+:: Name of the Job
    # +build_id+:: ID of the build
    def test_results(name, build_id)
      @client.api_request(:get, "/job/#{name}/#{build_id}/testReport")
    end

    # Get +console log+ for a specific build as text
    #
    # ==== Params:
    # +job_name+:: Name of the Job
    # +build_id+:: ID of the build
    #
    # Return an array of strings.
    # Each item in that array is a line from the log
    def logtext_lines(name, build_id)
      @client.api_request(:get, "/job/#{name}/#{build_id}/logText/progressiveText", :raw).split("\r\n")
    end

    # Get the name of the slave where the build was executed
    #
    # ==== Params:
    # +name+:: Name of the Job
    # +build_id+:: ID of the build
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
