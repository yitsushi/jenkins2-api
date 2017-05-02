require_relative 'base_endpoint'

module Jenkins2API
  module Endpoint
    # This class contains all the calls to reach
    # Jenkins2 Configuration
    class Configuration < BaseEndpoint
      # list all installed plugin
      def plugin_list
        @client.api_request(:get, '/pluginManager', depth: 10)['plugins']
      end

      # Install a plugin
      def plugin_install(name, short)
        json = { name => { default: true } }
        @client.api_request(
          :post,
          '/pluginManager/install',
          :raw,
          json: json.to_json,
          dynamicLoad: 'Install without restart',
          :"plugin.#{short}.default" => 'on'
        )
      end
    end
  end
end
