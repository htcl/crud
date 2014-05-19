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

  s.add_dependency 'rails' #, '~> 3.2'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  #s.add_dependency 'jquery-datatables-rails'

  s.add_dependency 'will_paginate'

  # RMagick
  if defined?(JRUBY_VERSION)
    s.add_development_dependency 'rmagick4j', '~> 0.3.7'
  else
    if RbConfig::CONFIG['target_os'] == 'linux'
      if `cat /etc/issue`.include? 'CentOS release 5'
        # The latest version which is known to be usable on CentOS 5
        s.add_development_dependency 'rmagick', '~> 1.15.17'
      else
        s.add_development_dependency 'rmagick', '~> 2.13.1'
      end
    else
      # HOWTO:
      # 1) Install ImageMagick in a top-level directory
      # 2) Set environment variables
      #    set CPATH=C:\ImageMagick-6.7.3-Q16\include
      #    set LIBRARY_PATH=C:\ImageMagick-6.7.3-Q16\lib
      # 3) gem install rmagick -v 2.13.1
      s.add_development_dependency 'rmagick', '~> 2.13.1'
    end
  end

  if defined?(JRUBY_VERSION)
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
    s.add_development_dependency 'activerecord-jdbc-adapter'
    s.add_development_dependency 'jdbc-sqlite3'
  else
    s.add_development_dependency "sqlite3"
  end
end
