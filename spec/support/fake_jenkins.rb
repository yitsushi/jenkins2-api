require 'sinatra/base'

# Fake Jenkins server for rspec
class FakeJenkins < Sinatra::Base
  get '/api/json' do
    json_response 200, 'job_list.json'
  end

  get '/job/sample-job-pipeline/144/api/json' do
    json_response 200, 'latest_build.json'
  end

  get '/job/sample-job-pipeline/lastBuild/api/json' do
    json_response 200, 'latest_build.json'
  end

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
