#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Crud'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Encourage the visibilty of application-bourne rake tasks
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

# Test::Unit tasks
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


# RSpec 1.x tasks
#require 'spec/version'
#require 'spec/rake/spectask'

# RSpec 2.x tasks
if Rails.version.to_i < 3
  require 'spec/rake/spectask'
  rspec_task_class = 'Spec::Rake::SpecTask'
else
  require 'rspec/core/rake_task'
  rspec_task_class = 'RSpec::Core::RakeTask'
end
rspec_task_class.constantize.new(:spec)

# Alias for cucumber task
task :cucumber => 'app:cucumber'

# ci_reporter tasks
require 'rubygems'
require 'ci/reporter/rake/test_unit' # use this if you’re using Test::Unit
require 'ci/reporter/rake/rspec'     # use this if you’re using RSpec
require 'ci/reporter/rake/cucumber'  # use this if you're using Cucumber

# Aliases for CI tasks
task 'ci:all' => 'app:ci:all'
task 'ci:install_vendor_migrations' => 'app:ci:install_vendor_migrations'
task 'ci:all_tests' => 'app:ci:all_tests'

task :default => [:spec, :cucumber]

# Other useful aliases
task :routes => 'app:routes'
task :guard  => 'app:guard'

Bundler::GemHelper.install_tasks
