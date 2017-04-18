require_relative 'base_endpoint'

module Jenkins2API
  module Endpoint
    # This class contains all the calls to reach
    # Jenkins2 and obtain Artifact data
    class Artifact < BaseEndpoint
      # Returns a list of all artifacts for a specific build
      #
      # Params:
      # +name+:: Job name
      # +build_id+:: ID of the build
      def all(name, build_id)
        @client.build.get(name, build_id)['artifacts']
      end

      # Download a specific artifact.
      #
      # Params:
      # +name+:: Job name
      # +build_id+:: ID of the build
      # +artifact+:: artifact +Hash+.
      # This function uses only the +relativePath+ property
      #
      # Returns with the content of the artifact
      def get(name, build_id, artifact)
        @client.api_request(
          :get,
          "/job/#{name}/#{build_id}/artifact/#{artifact['relativePath']}",
          :raw
        )
      end
    end
  end
end
