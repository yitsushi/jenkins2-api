require 'jenkins2-api'
require 'net/http'

RSpec.describe Jenkins2API::Endpoint::Job, '#latest' do
  context 'get the latest build for a job' do
    it 'returns with the build' do
      build = @client.build.latest('sample-job-pipeline')

      expect(build['id']).to eq('144')
      expect(build['displayName']).to eq('#144')
    end
  end
end

RSpec.describe Jenkins2API::Endpoint::Job, '#get' do
  context 'get a specific build for a job' do
    it 'returns with the build' do
      build = @client.build.get('sample-job-pipeline', 144)

      expect(build['id']).to eq('144')
      expect(build['displayName']).to eq('#144')
    end
  end

  context 'get an invalid build for a job' do
    it 'returns with the build' do
      expect do
        @client.build.get('sample-job-pipeline', 135)
      end.to raise_error(Net::HTTPServerException, /Not Found/)
    end
  end
end
