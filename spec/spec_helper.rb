$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
$:.unshift File.expand_path(File.dirname(__FILE__))

ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
require 'rspec'
require 'webmock/rspec'
require 'factory_girl'
require 'faker'
require 'biola_web_api'
require 'buweb_api_client'
require 'pry'

BiolaWebAPI.initialize!

FactoryGirl.find_definitions

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |f| require f }

BUWebAPIClient.configure do |config|
  config.script_name = nil
  config.access_id = Helpers.access_id
  config.secret_key = Helpers.secret_key
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include SyncinatorHelpers

  config.before do
    stub_request(:any, /.*/).to_rack BUWeb::API
  end

  # Clean/Reset Mongoid DB prior to running each test.
  config.before(:each) do
    Mongoid::Sessions.default.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end