require 'spec_helper'

module Crud
  describe DashboardController do

    describe "GET 'index'" do
      it "returns http success" do
        get 'index', {:use_route => :crud}
        response.should be_success
      end
    end

  end
end
