$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "easy_api_doc/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "easy_api_doc"
  s.version     = EasyApiDoc::VERSION
  s.authors     = ["Jeremy Olliver", "Nigel Ramsay", "Marcus Baguley"]
  s.email       = ["jeremy.olliver@abletech.co.nz", "nigel.ramsay@abletech.co.nz", "marcus.baguley@abletech.co.nz"]
  s.homepage    = "http://www.abletech.co.nz"
  s.summary     = "Documents your API with executable examples."
  s.description = "Use a YAML file to specify your API, and EasyApiDoc will serve up this information with executable examples."
  s.license = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", [">= 4.0.0", '< 4.2']
  s.add_dependency "github-markup", "~> 0.7.2"
  s.add_dependency "redcarpet"
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'jquery-rails'

end
