module BUWeb
  module APIClient
    class Departments < Weary::Client
      domain BUWebAPIClient.config.base_url
      use Weary::Middleware::HMACAuth, [BUWebAPIClient.config.credentials]

      get :index, '/departments' do |resource|
        resource.optional :location
      end

      get :show, '/departments/{id}'
    end
  end
end