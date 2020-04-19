require 'rails'

module Crud
  class Engine < ::Rails::Engine
    isolate_namespace Crud

    # Make the asset pipeline of the following gems available to the application
    require 'jquery-rails'
    require 'jquery-ui-rails'
    #require 'jquery-datatables-rails'
    require 'will_paginate'

    config.generators do |g|
      g.test_framework :rspec, :fixture_replacement => :factory_bot, :views => false, :helper => true
      g.view_specs false
      g.helper_specs true
      g.fixture_replacement :factory_bot, :dir => 'spec/factories'
    end

    #config.autoload_paths << File.expand_path("../validators", __FILE__)

    # monkey patch via: http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/
    initializer "crud.migrations" do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each { |expanded_path| app.config.paths['db/migrate'] << expanded_path }
      end
    end

    initializer "crud.factories", after: "factory_bot.set_factory_paths" do
      if Rails.env.test?
        puts "Loading factories from #{self.class.name} engine"
        FactoryBot.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryBot)
      end
    end

    # Load translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[File.join(File.dirname(__FILE__), '..', '..', 'config', 'locales', '**', '*.{rb,yml}').to_s]

    # Execute local initializers for any in-house gems
    # initializer "crud.load_config_initializers", :after => :load_config_initializers do |app|
    #   Rails.logger.info "Crud::Engine : Loading initializers"
    #   require File.join(File.dirname(__FILE__), '..', '..', 'config', 'in_house_gems')
    #   in_house_engines = CRUD_IN_HOUSE_ENGINES
    #   in_house_engines.each do |in_house_engine|
    #     initializer = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'initializers', "#{in_house_engine.to_s}.rb"))
    #     Rails.logger.info "Crud::Engine : Loading '#{initializer}'"
    #     require initializer if File.exist? initializer
    #   end
    # end

  end
end
