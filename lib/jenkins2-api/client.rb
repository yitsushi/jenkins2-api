require 'net/http'
require 'json'

module Jenkins2API
  class Client
    def initialize(**options)
      @server   = options[:server]    || 'http://127.0.0.1/'
      @username = options[:username]
      @password = options[:password]

      if @username && !@password
        raise ArgumentError, "If username is provided, password is required"
      end
    end

    def latest_build_for(name)
      api_request(:get, "/job/#{name}/lastBuild")
    end

    def list_jobs
      api_request(:get, "")['jobs']
    end

    def nodes
      api_request(:get, "/computer")
    end

    def get_full_log_lines(name, build_id)
      api_request(:get, "/job/#{name}/#{build_id}/logText/progressiveText", :raw).split("\r\n")
    end

    def get_artifact_for(name, build_id, artifact)
      api_request(:get, "/job/#{name}/#{build_id}/artifact/#{artifact['relativePath']}", :raw)
    end

    def get_build_slave_name(name, build_id)
      log = get_full_log_lines(name, build_id)
      relevant_line = log.select { |line| line.match(/^Running on /) }.first

      relevant_line.match(/^Running on (.*) in \//)[1]
    end

    private
    def api_request(method, path, response_type = :json, **opts)
      response_type = :json unless [:json, :raw].include?(response_type)

      parts = [@server, URI.escape(path)]
      parts << 'api/json' if response_type == :json
      uri = URI(File.join(parts))
      uri.query = URI.encode_www_form(opts)

      req = case method
              when :get then Net::HTTP::Get
              when :post then Net::HTTP::Post
      end.new(uri)

      req.basic_auth @username, @password
      yield req if block_given?
      req.content_type ||= 'application/x-www-form-urlencoded'
      response = Net::HTTP.start(req.uri.hostname, req.uri.port) { |http| http.request req }

      case response
        when Net::HTTPSuccess
          if response_type == :json
            JSON.parse(response.body)
          else
            response.body
          end
        when Net::HTTPRedirection
          puts "Redirect: #{response['location']}"
          response['location']
        else
          puts "Response: #{response.code}, #{response.body}"
          response.value
      end
    end
  end
end
