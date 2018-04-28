require_dependency "crud/crud_base_controller"

module Crud
  class DashboardController < CrudBaseController

    if Rails.version.to_f >= 5.1
      before_action :get_klass_list
    else
      before_filter :is_allowed_to_view?, :only => [:index]
      before_filter :get_klass_list
    end

    def index
    end

    private

    def get_klass_list
      @klass_list = Crud::KlassList.new() unless @klass_list
    end
  end
end
