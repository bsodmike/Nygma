$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nygma/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nygma"
  s.version     = Nygma::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Nygma."
  s.description = "TODO: Description of Nygma."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.8"

  s.add_development_dependency "sqlite3"
end
