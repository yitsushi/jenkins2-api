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
```
