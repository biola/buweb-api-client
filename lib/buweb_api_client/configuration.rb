require 'uri'

module BUWebAPIClient
  class Configuration
    attr_accessor :access_id
    attr_accessor :secret_key

    attr_accessor :scheme
    attr_accessor :host
    attr_accessor :script_name
    attr_accessor :version

    def initialize
      @scheme = 'https'
      @host = 'api.biola.edu'
      @script_name = 'web'
      @version = 'v1'
    end

    def base_url
      URI.join(root_url, "/#{script_name}/", version).to_s
    end

    def credentials
      {access_id: access_id, secret_key: secret_key}
    end

    private

    def root_url
      URI::Generic.build(scheme: scheme, host: host)
    end
  end
end