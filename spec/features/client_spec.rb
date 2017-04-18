require 'jenkins2-api'

RSpec.describe Jenkins2API::Client, '#initialize' do
  context 'connect without credentials' do
    it 'throws an error' do
      expect do
        Jenkins2API::Client.new
      end.to raise_error(ArgumentError)
    end
  end

  context 'connect with credentials' do
    it 'does not throw an error' do
      expect do
        Jenkins2API::Client.new(
          username: 'myuser',
          password: 'mytoken'
        )
      end.not_to raise_error
    end
  end
end
