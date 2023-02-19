require 'rails_helper'

RSpec.describe "CommonActions", type: :request do
  describe "GET /show_inn" do
    it "returns http success" do
      get "/common_actions/show_inn"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /clear_business" do
    it "returns http success" do
      get "/common_actions/clear_business"
      expect(response).to have_http_status(:success)
    end
  end
  
end
