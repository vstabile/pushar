$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pushar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pushar"
  s.version     = Pushar::VERSION
  s.authors     = ["Victor Morandini Stabile", "Alexandre Koji Imai Negrão"]
  s.email       = ["vstabile@gmail.com", "akin@usp.br"]
  s.homepage    = "http://www.bonitasmensagens.com.br"
  s.summary     = "Gem de gerenciamento para envio de newsletters e push notifications."
  s.description = "Gem de gerenciamento para envio de newsletters e push notifications."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "jquery-rails"
  s.add_dependency  "anjlab-bootstrap-rails", ">= 3.0"

  # s.add_dependency "core"
  # s.add_dependency "admin"
  # s.add_dependency "api"

  s.add_development_dependency "sqlite3"
end
