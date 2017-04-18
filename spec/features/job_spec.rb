require 'jenkins2-api'

RSpec.describe Jenkins2API::Endpoint::Job, '#list' do
  context 'get the list of available jobs' do
    it 'returns an array of two jobs' do
      jobs = @client.job.list
      expect(jobs.length).to eq(2)
    end
  end
end

