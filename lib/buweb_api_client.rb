require 'weary'

module BUWebAPIClient
  require 'buweb_api_client/configuration'

  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end
end

module BUWeb
  module APIClient
    autoload :People, 'buweb/api_client/people'
    autoload :Departments, 'buweb/api_client/departments'
  end
end

module Weary
  module Middleware
    autoload :HMACAuth, 'weary/middleware/hmac_auth'
  end
end