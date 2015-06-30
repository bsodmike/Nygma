$:.push File.expand_path("../lib", __FILE__)
require "nygma/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "nygma"
  spec.version     = Nygma::VERSION
  spec.authors       = ["Michael de Silva"]
  spec.email         = ["hello@inertialbox.com"]
  spec.homepage      = "http://inertialbox.com"
  spec.summary       = "Gotham's very own Mr. Nygma, a Rails 4 Encryptor"
  spec.description   = spec.summary
  spec.license       = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.required_ruby_version = '~> 2.2.0'

  spec.add_dependency 'rails', '~> 4.2.0'
  spec.add_dependency 'attr_extras'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'fuubar'
end
