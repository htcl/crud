require 'rails'

module Crud
  class Engine < ::Rails::Engine
    isolate_namespace Crud

    # Make the asset pipeline of the following gems available to the application
    require 'jquery-rails'
    require 'jquery-ui-rails'
    #require 'jquery-datatables-rails'
    require 'will_paginate'

    #config.autoload_paths << File.expand_path("../validators", __FILE__)

    config.generators do |g|
      g.test_framework :rspec, :fixture_replacement => :factory_bot, :views => false, :helper => true
      g.view_specs false
      g.helper_specs true
      g.fixture_replacement :factory_bot, :dir => 'spec/factories'
    end

    # Load translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[File.join(File.dirname(__FILE__), '..', '..', 'config', 'locales', '**', '*.{rb,yml}').to_s]
  end
end
