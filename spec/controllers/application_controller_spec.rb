require 'rails_helper'

RSpec.describe ApplicationController do
  describe "the server works" do
    it "should return success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
