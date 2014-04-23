lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'buweb_api_client/version'

spec = Gem::Specification.new do |s|
  s.name = 'buweb_api_client'
  s.version = BUWebAPIClient::VERSION
  s.summary = 'Client for the Biola Web API'
  s.description = 'API consuming models for the Biola Web API project'
  s.files = Dir['README.*', 'MIT-LICENSE', 'lib/**/*.rb']
  s.require_path = 'lib'
  s.author = 'Devin Hanlon'
  s.email = 'devin.hanlon@biola.edu'
  s.homepage = 'https://github.com/biola/buweb-api-client'
  s.license = 'MIT'
  s.add_dependency 'api-auth', '~> 1.0'
  s.add_dependency 'weary', '~> 1.0'
  s.add_development_dependency 'biola_web_api'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'webmock', '~> 1.17'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'faker', '~> 1.3'
  s.add_development_dependency 'pry', '~> 0.9'
  s.add_development_dependency 'pry-stack_explorer', '~> 0.4'
end
