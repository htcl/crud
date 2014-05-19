require_dependency "crud/application_controller"

module Crud
  class DashboardController < ApplicationController
    before_filter :is_allowed_to_view?, :only => [:index]
    before_filter :get_klass_list

    def index
    end

    private

    def get_klass_list
      @klass_list = Crud::KlassList.new() unless @klass_list
    end
  end
end
