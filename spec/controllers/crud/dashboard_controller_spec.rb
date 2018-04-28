require 'spec_helper'

module Crud
  describe DashboardController, :type => :controller do
    routes { ::Crud::Engine.routes }

    #def setup
    #  @routes = ::Crud::Engine.routes
    #end

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        expect(response).to be_success
      end
    end

  end
end
