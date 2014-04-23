require 'api_auth'

module Weary
  module Middleware
    class HMACAuth

      def initialize(app, config = {})
        @app = app
        @access_id = config[:access_id]
        @secret_key = config[:secret_key]
      end

      def call(env)
        set_content_type! env
        sign! env
        @app.call env
      end

      private

      attr_reader :access_id, :secret_key

      def set_content_type!(env)
        env.tap do |e|
          # Weary::Middleware::ContentType is dynamically injected after
          # this middleware is called and since Content-Type is used to
          # sign HMAC signatures, we have to mimic that behavior so that
          # there's no difference in the headers when it's authenticated.
          if ['POST', 'PUT'].include? e['REQUEST_METHOD']
            e.update 'CONTENT_TYPE' => 'application/x-www-form-urlencoded'
          end
        end
      end

      def signed_request(env)
        Rack::Request.new(env).tap do |r|
          ApiAuth.sign! r, access_id, secret_key
        end
      end

      def sign!(env)
        req = signed_request(env)

        env.tap do |e|
          # Weary wants all headers to be in HTTP_[UPCASE] format for Rack env compatibility
          e.update(
            'HTTP_AUTHORIZATION' => req.env['Authorization'],
            'HTTP_DATE' => req.env['DATE']
          )

          if md5 = req.env['Content-MD5']
            e.update 'HTTP_CONTENT_MD5' => md5
          end
        end
      end
    end
  end
end