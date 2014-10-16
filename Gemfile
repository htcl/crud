source "http://rubygems.org"

# Declare your gem's dependencies in core.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

if RUBY_VERSION.include?('1.8')
  gem 'rails', '~> 3.2.14'
else
  gem 'rails'
  gem 'protected_attributes'
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
  gem 'nokogiri', '~> 1.5.9'
  gem 'rubyzip', '0.9.9'
end

# Bundle gems which are only used in development mode:
group :debug do
  if RUBY_VERSION.to_f > 1.9
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

  gem 'spork'
  gem 'spork-testunit'
  gem 'spork-rails'

  if RUBY_VERSION.include?('1.8')
    gem 'guard', '~> 1.8.2'
  else
    gem 'guard'
  end
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-livereload'
  gem 'guard-test'
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
  gem 'capistrano'

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
    gem 'rspec-rails'
  end
  if RUBY_VERSION.include?('1.8')
    gem 'factory_girl_rails', '~> 1.7.0'
    gem 'capybara', '~> 2.0.3'
  else
    gem 'factory_girl_rails'
    gem 'capybara'
  end
  gem 'faker'
  gem 'database_cleaner'
  #gem 'email_spec'

  gem 'cucumber-rails', :require => false
  gem 'cucumber'
  gem 'launchy'
  gem 'ci_reporter', '~> 1.9.2'

  # RMagick
  if defined?(JRUBY_VERSION)
    gem 'rmagick4j', '~> 0.3.7'
  else
    if RbConfig::CONFIG['target_os'] == 'linux'
      if `cat /etc/issue`.include? 'CentOS release 5'
        # The latest version which is known to be usable on CentOS 5
        gem 'rmagick', '~> 1.15.17'
      else
        gem 'rmagick', '~> 2.13.1'
      end
    else
      # HOWTO:
      # 1) Install ImageMagick in a top-level directory
      # 2) Set environment variables
      #    set CPATH=C:\ImageMagick-6.7.3-Q16\include
      #    set LIBRARY_PATH=C:\ImageMagick-6.7.3-Q16\lib
      # 3) gem install rmagick -v 2.13.1
      gem 'rmagick', '~> 2.13.1'
    end
  end

  ## Other test gems should be added here ##
end

# Bundle gems which are only used in production mode:
group :production do

  ## Other 'production' gems should be added here ##
end
