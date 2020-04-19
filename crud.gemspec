# Encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "crud/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "crud"
  s.version     = Crud::VERSION::STRING.dup
  s.authors     = ["Everard Brown"]
  s.email       = ["Everard.Brown@htcl.eu"]
  s.homepage    = "https://github.com/htcl/crud"
  s.summary     = "Crud engine (v#{s.version})"
  s.description = "Performs CRUD operations by reflection"
  s.license     = 'GPL-3.0'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["#{s.name}.gemspec", "Rakefile", "LICENSE.md", "README.md"]
  #s.test_files = Dir["{test,spec,features}/**/*"]
  s.require_paths = ["lib"]

  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "crud", "--main", "README.md"]
  s.extra_rdoc_files = ["CHANGELOG", "README.md", "lib/tasks/crud_tasks.rake", "lib/crud.rb"]

  s.add_dependency 'rails', '>= 5.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'will_paginate'

  #s.add_development_dependency 'sqlite3'
end
