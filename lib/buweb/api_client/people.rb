module BUWeb
  module APIClient
    class People < Weary::Client
      domain BUWebAPIClient.config.base_url
      use Weary::Middleware::HMACAuth, [BUWebAPIClient.config.credentials]

      get :index, '/people' do |resource|
        resource.optional :affiliation
      end

      get :show, '/people/{id}'
    end
  end
end