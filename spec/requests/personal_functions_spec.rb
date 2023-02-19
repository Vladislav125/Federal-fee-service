require 'rails_helper'

RSpec.describe "PersonalFunctions", type: :request do
  describe "GET /add_income" do
    it "returns http success" do
      get "/personal_functions/add_income"
      expect(response).to redirect_to(sign_in_url)
    end
  end

  describe "GET /add_realty" do
    it "returns http success" do
      get "/personal_functions/add_realty"
      expect(response).to redirect_to(sign_in_url)
    end
  end

  describe "GET /add_vehicle" do
    it "returns http success" do
      get "/personal_functions/add_vehicle"
      expect(response).to redirect_to(sign_in_url)
    end
  end

  describe "GET /payments_info" do
    it "returns http success" do
      get "/personal_functions/payments_info"
      expect(response).to redirect_to(sign_in_url)
    end
  end

  describe "GET /pay" do
    it "returns http success" do
      get "/personal_functions/pay"
      expect(response).to redirect_to(sign_in_url)
    end
  end

  describe "GET /posession_info" do
    it "returns http success" do
      get "/personal_functions/posession_info"
      expect(response).to redirect_to(sign_in_url)
    end
  end

end
