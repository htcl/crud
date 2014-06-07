# CRUD

This gem is a simple mechanism to allow you to develop your rails applications using models and custom views alone (no need to generate and throw away scaffolding anymore).

It provides all of the basic CRUD functionality of the standard controllers/views generated by the scaffolding operations.

There are some small extensions which will allow you to extend the functionality for your own purpose.

## Usage

To 'Gemfile', add:

    gem 'crud'

To 'config/routes.rb', add:

    mount Crud::Engine => "/crud", :as => :crud


Create 'config/iniializers/crud.rb', containing:

    # Initialisation
    Crud.setup do |config|
      # Set model path
      # Allow clients to register paths containing models. The backend determines
      # acceptable model sources.
      #
      # Clients may register additional paths like this:
      #   model_path << 'path/to/model/directory'
      config.model_path << File.join(Rails.root, 'app', 'models')


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

    end

Start and browse to your application url '/crud'

    http://localhost:3000/crud

## Examples

See the test application under spec/dummy

## Links

* Homepage: <https://github.com/htcl/crud>
* Source code: <https://github.com/htcl/crud>
* RubyGem: <https://rubygems.org/gems/crud>
* Travis CI: <https://travis-ci.org/htcl/crud>

## Authors

* Everard Brown <mailto:everard.brown@htcl.eu>

## Licence

Copyright (c) 2013-2014 Everard Brown

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Level is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Level. If not, see <http://www.gnu.org/licenses/>

