source "http://rubygems.org"

# Declare your gem's dependencies in crud.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

if RUBY_VERSION.include?('1.8')
  gem 'rails', '~> 3.2.14'
else
  gem 'rails'
end

if defined?(JRUBY_VERSION)
  gem 'jruby-openssl'
  gem 'jruby-rack'
end

gem 'json'

# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

# jquery-rails is used by the dummy application
gem 'jquery-rails'
gem 'jquery-ui-rails'
#gem 'jquery-datatables-rails'

gem 'turbolinks'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', :require => false
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'ruby-debug'

# Limit some gem versions for 1.8.7 compatibility
if RUBY_VERSION.include?('1.8')
  gem 'i18n', '~> 0.6.9'
  gem 'nokogiri', '~> 1.5.9'
  gem 'rubyzip', '0.9.9'
  gem 'highline', '~> 1.6.21'
  gem 'execjs', '~> 2.0.2'
  gem 'ruby-graphviz', '~> 1.0.9'
end

# Bundle gems which are only used in development mode:
group :debug do
  if RUBY_VERSION.to_f > 1.9 && RUBY_VERSION.to_f < 2.3
    gem 'debugger' unless defined?(JRUBY_VERSION)
  end

  #if RUBY_VERSION.include?('1.9')
  #  gem 'ruby-debug19'
  #else
  #  gem 'ruby-debug'
  #end
end

# Bundle gems which are only used in development mode:
group :development do

  if defined?(JRUBY_VERSION)
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbc-adapter'
    gem 'jdbc-sqlite3'
  else
    gem 'sqlite3'
  end

  #gem 'spork-rails'
  #gem 'spork-testunit'
  #gem 'spork'

  if RUBY_VERSION.include?('1.8')
    gem 'guard-rails', '~> 0.4.7'
    gem 'guard-test', '~> 1.0.0'
    gem 'guard', '~> 1.8.2'
  else
    gem 'guard-rails'
    gem 'guard-test'
    gem 'guard'
  end
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'rack-livereload'

  unless defined?(JRUBY_VERSION)
    if RUBY_VERSION.include?('1.8')
      gem 'ruby-prof', '~> 0.10.8'
    else
      gem 'ruby-prof'
    end
  end

  case RbConfig::CONFIG['target_os']
  when /darwin/i
    gem 'rb-fsevent'
    gem 'growl'
  when /linux/i
    gem 'libnotify'
    gem 'rb-inotify', '~> 0.9'
  when /mswin|windows|mingw32/i
    gem 'rb-fchange'
    gem 'win32console'
    gem 'rb-notifu'
  end

  gem 'railroady'
  gem 'rails-erd'
  gem 'warbler'
  gem 'net-ssh'
  gem 'net-scp'

  if RUBY_VERSION.include?('1.8')
    gem 'capistrano', '~> 2.6.0'
  else
    gem 'capistrano'
  end

  gem 'webrick', '1.3.1'

  ## Other 'development' gems should be added here ##
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  #gem 'rcov', '~> 0.9.9'
  if RUBY_VERSION.include?('1.8')
    gem 'simplecov', '~> 0.8.2', :require => false, :group => :test
    gem 'shoulda-matchers', '~> 1.2.0'
  else
    gem 'simplecov', :require => false, :group => :test
    gem 'shoulda-matchers'
  end
  gem 'simplecov-rcov', :require => false, :group => :test

  if RUBY_VERSION.include?('1.8')
    gem 'rspec-rails', '~> 2.14.0'
  elsif RUBY_VERSION.include?('1.9')
    gem 'rspec-rails', '~> 2.14.0'
  else
    gem 'rails-controller-testing'
    gem 'rspec-rails'
  end

  gem 'cucumber-rails', :require => false
  gem 'cucumber'
  gem 'launchy'

  gem 'factory_bot_rails'
  gem 'faker'
  #gem 'email_spec'
  gem 'database_cleaner'

  if RUBY_VERSION.include?('1.8')
    gem 'capybara', '~> 2.0.3'
  else
    gem 'capybara'
  end

  gem "selenium-webdriver"

  #gem 'ci_reporter' #, '~> 1.9.2'
  #gem 'ci_reporter_test_unit'
  gem 'ci_reporter_minitest'
  gem 'ci_reporter_rspec'
  gem 'ci_reporter_cucumber'

  ## Other test gems should be added here ##
end

# Bundle gems which are only used in production mode:
group :production do

  ## Other 'production' gems should be added here ##
end
