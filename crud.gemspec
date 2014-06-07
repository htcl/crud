# Encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "crud/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "crud"
  s.version     = Crud::VERSION.dup
  s.authors     = ["Everard Brown"]
  s.email       = ["Everard.Brown@htcl.eu"]
  s.homepage    = "http://htcl.eu"
  s.summary     = "Crud engine (v#{s.version})"
  s.description = "Performs CRUD operations by reflection"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["#{s.name}.gemspec", "Rakefile", "LICENSE.md", "README.rdoc"]
  #s.test_files = Dir["{test,spec,features}/**/*"]
  s.require_paths = ["lib"]

  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "crud", "--main", "README.rdoc"]
  s.extra_rdoc_files = ["CHANGELOG", "README.rdoc", "lib/tasks/crud_tasks.rake", "lib/crud.rb"]

  s.add_dependency 'rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'

  s.add_dependency 'will_paginate'
end
