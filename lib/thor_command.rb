require 'thor'

module Jenkins2API
  class ThorCommand < Thor
    class_option :password, :desc => "Password", :aliases => "-p", :required => false
    class_option :username, :desc => "Username", :aliases => "-u", :required => false
    class_option :server, :desc => "Server path", :aliases => "-s", :required => false

    private
    def client
      check_option(:server, 'JENKINS_SERVER')
      check_option(:username, 'JENKINS_USERNAME')
      check_option(:password, 'JENKINS_PASSWORD')

      @client ||= Jenkins2API::Client.new(
        :server   => options[:server],
        :username => options[:username],
        :password => options[:password]
      )
    end

    def check_option(name, env_name)
      options[name] ||= ENV.fetch(env_name, '')

      unless options.has_key?(name.to_s) && options[name] != ''
        fail Thor::Error, "#{name} is not defined. " \
          "You can specify with --#{name} option " \
          "or '#{env_name}' environment variable."
      end
    end
  end
end
