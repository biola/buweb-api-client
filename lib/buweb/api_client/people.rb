module BUWeb
  module APIClient
    class People < Weary::Client
      domain BUWebAPIClient.config.base_url
      # use Weary::Middleware::ContentType
      use Weary::Middleware::HMACAuth, [BUWebAPIClient.config.credentials]

      get :index, '/people' do |resource|
        resource.optional :affiliation
      end

      get :by_id, '/people/{id}' do |resource|
        resource.optional :type
      end
    end
  end
end