# To use the mattr functions, ActiveSupport dependencies are required.
#require 'rails'
require "active_support/dependencies"

module Crud

  # Our host application root path
  # We set this when the engine is initialised
  # mattr_accessor :app_root
  # @@app_root = 'xyz'

  # Allow clients to register paths containing models. The backend determines
  # acceptable model sources.
  #
  # Clients may register additional paths like this:
  #   model_path << 'path/to/model/directory'
  mattr_accessor :model_path
  self.model_path ||= []

  # Access permissions
  #
  # Holds the definition of a proc which should be called. If the returned
  # value is true then user is granted the access. Otherwise access is denied.
  mattr_writer :is_allowed_to_view
  #self.is_allowed_to_view = true
  def self.is_allowed_to_view
    is_allowed = @@is_allowed_to_view.nil? ? lambda { return true } :
      lambda {|controller| return ((@@is_allowed_to_view.class == Proc) ? @@is_allowed_to_view.call(controller) : @@is_allowed_to_view)}

    is_allowed
  end

  # Holds the definition of a proc which should be called. If the returned
  # value is true then user is granted the access. Otherwise access is denied.
  mattr_writer :is_allowed_to_update
  #self.is_allowed_to_update = false
  def self.is_allowed_to_update
    is_allowed = @@is_allowed_to_update.nil? ? lambda { |controller| return true } :
      lambda {|controller| return ((@@is_allowed_to_update.class == Proc) ? @@is_allowed_to_update.call(controller) : @@is_allowed_to_update)}

    is_allowed
  end

  # Allow clients to customise the appearance of fields when rendering model data.
  #
  # :class
  # The fully qualified name of the model to which this definition applies
  #
  # NOTE: If :class is set to :all, the definition will apply to all models.
  #
  # :hidden_fields
  # If :hidden_fields contains an existing column, the column will not be displayed
  #
  # :only
  # Filter to define in which views this definition applies.
  # Valid values: :index, :show, :new, :edit
  #
  # Clients may register column settings like this:
  #   column_settings << { :class => 'Model',
  #                        :hidden_fields => [:id, :created_at, :updated_at],
  #                        :only => [:index, :show ]
  #                      }
  #
  #   column_settings << { :class => :all,
  #                        :hidden_fields => [:id, :created_at, :updated_at],
  #                        :only => [:index, :show],
  #                      }
  #
  mattr_accessor :column_settings
  self.column_settings ||= []

  # Allow clients to register additional customisation to fields when rendering
  # model data.
  #
  # :global
  # If :global is specified and set to 'true', the partial will be at the end
  # as an extension of the active view.
  #
  # :column_name
  # If :column_name is an existing column, the partial will be rendered alongside
  # the default, unless :column_replacement is set to true
  #
  # NOTE: The functionality of :column_name and :global are mutually exclusive.
  #       As such, if both are specified, :global will take presedence
  #
  # :column_replacement
  # Flag to indicate whether this customisation should replace the default or
  # appear alongside the default.
  #
  # :record_data_parameter
  # :record_data_parameter is the name of the symbol used for passing the record
  # data to the partial.
  #
  # :additional_partial_parameters
  # A hash containing any additional partial parameters
  #
  # :only
  # Filter to define in which views the extension applies.
  # Valid values: :index, :show, :new, :edit
  #
  # Clients may register custom fields like this:
  #   custom_fields << { :class => 'Model',
  #                      :only => [:index, :show ],
  #                      :global => false,
  #                      :column_name => 'id',
  #                      :column_replacement => true,
  #                      :partial => 'partial_path', :record_data_parameter => 'data',
  #                      :additional_partial_parameters => {:size => 20, :contract => true}
  #                    }
  #
  mattr_accessor :custom_fields
  self.custom_fields ||= []

  # Default way to setup the engine.
  #
  # Run 'rails generate crud_install' to create a fresh initializer with all
  # configuration values.
  def self.setup
    yield self
  end

  def self.railtie_name
    ::Crud::Engine.railtie_name
  end

  def self.mounted_path
    ::Crud::Engine.mounted_path
  end

  def self.root_path
    ::Crud::Engine.root
  end

end

# Require our engine
require 'crud/version'
require 'crud/engine'
