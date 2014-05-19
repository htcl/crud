source "http://rubygems.org"

# Declare your gem's dependencies in core.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

if RUBY_VERSION =~ /1.8/
  gem 'rails', '~> 3.2.14'
else
  gem 'rails', '~> 4.0.1'
  gem 'protected_attributes'
end


if defined?(JRUBY_VERSION)
  gem 'jruby-openssl'
  gem 'jruby-rack'
end

gem 'json'

# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails' #, '~> 3.2.5'
  gem 'coffee-rails' #, '~> 3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier' #, '>= 1.3.0'
end

# jquery-rails is used by the dummy application
#gem 'jquery-rails'
#gem 'jquery-ui-rails'
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
if RUBY_VERSION =~ /1.8/
  gem 'nokogiri', '~> 1.5.9'
  gem 'rubyzip', '0.9.9'
end

# Bundle gems which are only used in development mode:
group :development do

  if defined?(JRUBY_VERSION)
    gem 'activerecord-oracle_enhanced-adapter'
    gem 'activerecord-jdbc-adapter'
    gem 'jdbc-jtds'

    gem 'activerecord-jdbcpostgresql-adapter'
    gem 'activerecord-jdbc-adapter'
    gem 'jdbc-postgres'

    gem 'activerecord-jdbcmysql-adapter'
    gem 'activerecord-jdbc-adapter'
    gem 'jdbc-mysql'

    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbc-adapter'
    gem 'jdbc-sqlite3'
  else
    gem 'activerecord-oracle_enhanced-adapter'
    if RUBY_VERSION =~ /1.8/
      gem 'ruby-oci8', '2.1.5'
    else
      gem 'ruby-oci8'
    end

    if (RbConfig::CONFIG['target_os'] == 'linux') && (`cat /etc/issue`.include?('CentOS release 5'))
      # The latest version which is known to be usable on CentOS 5
      gem 'pg', '~> 0.12.2'
    else
      if RUBY_VERSION =~ /1.8/
        gem 'pg', '0.14.0'
      else
        gem 'pg'
      end
    end
    gem 'pg_comment'
    ##gem 'postgres', '~> 0.7.9.2008.01.28'

    gem 'mysql' #, '~> 2.8.1'

    gem 'sqlite3' #, '~> 1.3.4'
    #gem 'sqlite3-ruby', '~> 1.2.5'
  end

  gem 'spork' #, '~> 0.9.0'
  gem 'spork-testunit' #, '~> 0.0.8'
  gem 'spork-rails'

  if RUBY_VERSION =~ /1.8/
    gem 'guard', '~> 1.8.2'
  else
    gem 'guard', '>= 0.6.2'
  end
  gem 'guard-bundler', '>= 0.1.3'
  gem 'guard-rails', '>= 0.1.0'
  gem 'guard-livereload', '>= 0.4.0'
  gem 'guard-test', '>= 0.4.3'
  gem 'guard-rspec', '>= 0.6.0'
  gem 'guard-cucumber', '>= 0.7.5'
  gem 'guard-spork', '>= 0.8.0'
  gem 'rack-livereload', '>= 0.3.4'

  unless defined?(JRUBY_VERSION)
    gem 'ruby-prof', '~> 0.10.8'
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
  gem 'warbler', '~> 1.3.4'
  gem 'net-ssh', '~> 2.1.4'
  gem 'net-scp', '~> 1.0.4'
  gem 'capistrano', '~> 2.6.0'

  gem 'webrick', '1.3.1'

  ## Other 'development' gems should be added here ##
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  #if RUBY_VERSION.include?('1.9')
  #  gem 'ruby-debug19'
  #else
  #  gem 'ruby-debug'
  #end

  #gem 'rcov', '~> 0.9.9'
  if RUBY_VERSION =~ /1.8/
    gem 'simplecov', '~> 0.8.2', :require => false, :group => :test
  else
    gem 'simplecov', :require => false, :group => :test
  end
  gem 'simplecov-rcov', :require => false, :group => :test
  gem 'rspec-rails', '~> 2.14.0'
  gem 'shoulda-matchers', '~> 1.2.0'
  if RUBY_VERSION =~ /1.8/
    gem 'factory_girl_rails', '~> 1.7.0'
  else
    gem 'factory_girl_rails', '~> 4.2.1'
  end
  gem 'faker', '>= 1.2.0'
  gem 'database_cleaner', '~> 1.0.1'
  gem "email_spec", ">= 1.2.1"

  #gem 'cucumber', '~> 0.9.4'
  gem 'cucumber-rails', '>= 1.3.0', :require => false
  gem 'cucumber', '~> 1.2.5'
  gem "launchy", "~> 2.0.5"
  gem "capybara", "~> 2.0.3"
  #gem 'gherkin', '~> 2.2.9'
  #gem 'webrat', '~> 0.7.3'
  gem 'ci_reporter', '~> 1.7.0'

  ## Other test gems should be added here ##
end

# Bundle gems which are only used in production mode:
group :production do

  ## Other 'production' gems should be added here ##
end
