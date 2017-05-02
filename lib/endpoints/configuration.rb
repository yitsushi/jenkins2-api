require_relative 'base_endpoint'

module Jenkins2API
  module Endpoint
    # This class contains all the calls to reach
    # Jenkins2 Configuration
    class Configuration < BaseEndpoint

      def plugin_list
        @client.api_request(:get, '/pluginManager', depth: 10)['plugins']
      end

      def plugin_install(name, short)
        opts = {

        }
        @client.api_request(
          :post,
          '/pluginManager/install',
          :raw,

          "plugin.#{short}.default": 'on',
          json: {name => {default: true}}.to_json,
          dynamicLoad: 'Install without restart'
        )
      end
    end
  end
end

