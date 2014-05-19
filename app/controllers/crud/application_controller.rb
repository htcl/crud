module Crud
  class ApplicationController < ActionController::Base
    # Make these methods available to views
    helper_method :is_allowed_to_view?
    helper_method :is_allowed_to_update?

    def is_allowed_to_view?
      ::Crud.is_allowed_to_view
    end

    def is_allowed_to_update?
      ::Crud.is_allowed_to_update
    end

    protected

    def back_url
      params[:back_url] || request.env['HTTP_REFERER'] || root_url
    end

    private

  end
end
