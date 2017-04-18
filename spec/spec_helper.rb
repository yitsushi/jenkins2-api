require 'webmock/rspec'
require 'support/fake_jenkins.rb'
require 'jenkins2-api'

WebMock.disable_net_connect!(allow_localhost: true)

def create_new_client
  client = Jenkins2API::Client.new(
    server:   'http://example.jenkins2.com',
    username: 'myuser',
    password: 'mytoken'
  )
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    @client = create_new_client
    stub_request(:any, /example.jenkins2.com/).to_rack(FakeJenkins)
  end
end
