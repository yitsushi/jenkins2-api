require 'net/http'
require 'json'

require_relative './endpoints/artifact'
require_relative './endpoints/build'
require_relative './endpoints/job'
require_relative './endpoints/node'

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

    def job
      @job ||= Job.new(self)
    end

    def build
      @build ||= Build.new(self)
    end

    def artifact
      @artifact ||= Artifact.new(self)
    end

    def node
      @node ||= Node.new(self)
    end

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
