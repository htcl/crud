
# Code extensions
module Crud
end

# Initialisation
Crud.setup do |config|
  # Set model path
  config.model_path << File.join(Rails.root, 'app', 'models')

  # Set access permissions
  config.is_allowed_to_view = lambda { |controller| return true if Rails.env.development? || controller.send('is_developer?') }
  config.is_allowed_to_update = lambda { |controller| return true if controller.send('is_developer?') }

  # Custom fields
  config.custom_fields << {
    :class => 'Colour',
    :only => [:index, :show],
    :column_name => 'colour_code',
    :partial => 'partials/colour_display', :record_data_parameter => 'colour'
  }
end
