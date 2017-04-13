[![Gem Version](https://badge.fury.io/rb/jenkins2-api.svg)](https://badge.fury.io/rb/jenkins2-api)

# API Client for Jenkins2

## Install

```
gem install jenkins2-api
```

## Executable

You can specify server and credentials with parameters:

```
--password
--username
--server
```

Or with environment variables:

```
JENKINS_SERVER=''
JENKINS_USERNAME=''
JENKINS_PASSWORD=''
```

Password can be a password or an API token from `/user/{user}/configure`

### List computers / nodes

```
# List all nodes
jenkins2api node all

# Only slaves
jenkins2api node slaves
```

### Get the name of the slave where a build was executed

```
jenkins2api build slave-name jobname buildid
```

If you build slave names contain an AWS EC2 ID, you you add `--ec2id` parameter to match for it
and then it will print out only the ec2 instance id.

```
jenkins2api build slave-name jobname buildid --ec2id
```

## Ruby side

All response are a generic Jenkins response. There are no wrapper classes around them.

Create a new client:

```
require 'jenkins2-api'

client = Jenkins2API::Client.new(
  :server   => 'http://jenkins.example.com/',
  :username => 'myusername',
  :password => 'myapitoken'
)
```

To list all the available jobs:

```
jobs = client.job.list
jobs.each do |job|
  puts "[%10s] #{job['name']}" % [job['color']]
end
```

List all node:

```
nodes = client.node.all
puts "Total Executors: #{nodes['totalExecutors']}"
puts "Busy Executors: #{nodes['busyExecutors']}"

puts "Executors:"
nodes['computer'].each do |computer|
  type = 'slave'
  type = 'master' if computer['_class'] == 'hudson.model.Hudson$MasterComputer'
  puts "  [%7s] #{computer['displayName']}" % [type]
end
```

Get a specific job's latest build information:

```
build = client.build.latest('my-job')

puts "Latest build: #{build['id']}"
puts "Result: #{build['result']}"
puts "URL: #{build['url']}"
logfiles = build['artifacts'].select { |artifact| artifact['fileName'].match(/.*\.xml$/) }

slave_name = client.build.slave_name('my-job', build['id'])

puts "Build on: #{slave_name}"
```

Process junit reports:

```
failed_tests = []
logfiles.each do |file|
  results = Nokogiri::XML(client.artifact.get('my-job', build['id'], file))
  failed_tests += results.xpath('//testcase').select do |testcase|
    !testcase.children.empty?
  end
end

puts "Failed tests:" unless failed_tests.empty?
failed_tests.each do |failed|
  puts "  [✘] #{failed['name']} on #{failed['classname']}"
end
```
