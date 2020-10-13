require_relative 'base_endpoint'

module Jenkins2API
  module Endpoint
    # This class contains all the calls to reach
    # Jenkins2 and obtain Build data
    class Build < BaseEndpoint
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
        @client.api_request(:get, "/job/#{name}/#{build_id}/testReport", :xml)
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
        @client.api_request(
          :get,
          "/job/#{name}/#{build_id}/logText/progressiveText",
          :raw
        ).split("\r\n")
      end

      # Get the name of the slave where the build was executed
      #
      # ==== Params:
      # +name+:: Name of the Job
      # +build_id+:: ID of the build
      def slave_name(name, build_id)
        log = logtext_lines(name, build_id)

        line = find_line(log, /^Running on /)
        name = first_match(line, %r{^Running on (.*) in /})

        if name.nil?
          line = find_line(log, /Building remotely on/)
          name = first_match(line, /Building remotely on (.*) in workspace/)
        end

        name
      end

      private

      # find the first item in a string array
      # that matches for a given regular expression
      def find_line(lines, expression)
        lines.select { |line| line.match(expression) }.first
      end

      # return the first capture block from a string
      # that matches for a given regular expression
      def first_match(line, expression)
        line.match(expression).captures.first
      rescue
        nil
      end
    end
  end
end
