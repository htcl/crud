# Initialise SimpleCov
require 'simplecov'

# Configure Rails Environment
require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  ENV["RAILS_ENV"] = "test"

  require File.expand_path("../../spec/dummy/config/environment.rb",  __FILE__)
  require "rails/test_help"

  Rails.backtrace_cleaner.remove_silencers!

  # Load support files
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

  # Load fixtures from the engine
  if ActiveSupport::TestCase.method_defined?(:fixture_path=)
    ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
