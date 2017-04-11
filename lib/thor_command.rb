require 'thor'

module Jenkins2API
  class ThorCommand < Thor

    private
    def client
      @client ||= Jenkins2API::Client.new(
        :server   => options[:server],
        :username => options[:username],
        :password => options[:password]
      )
    end
  end
end
