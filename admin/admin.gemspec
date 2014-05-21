$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "admin"
  s.version     = Pushar::Admin::VERSION
  s.authors     = ["Alexandre Koji Imai Negrao"]
  s.email       = ["akin@usp.br"]
  s.homepage    = "http://www.bonitasmensagens.com.br"
  s.summary     = "Admin user tools"
  s.description = "Admin user tools"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "ransack"
  s.add_dependency "kaminari"
  s.add_dependency "core"

  s.add_development_dependency "sqlite3"
end
