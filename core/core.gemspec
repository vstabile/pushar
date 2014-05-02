$:.push File.expand_path("../lib", __FILE__)
require 'email_tracker/rack'

# Maintain your gem's version:
require "core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "core"
  s.version     = Pushar::Core::VERSION
  s.authors     = ["Alexandre Koji Imai Negrão"]
  s.email       = ["akin@usp.br"]
  s.homepage    = ""
  s.summary     = "Core engine."
  s.description = "Core engine."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.0"

  s.add_development_dependency "sqlite3"
end
