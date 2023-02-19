require 'rails_helper'

RSpec.describe "PersonalAccounts", type: :request do
  describe "GET /main_page" do
    it "returns http success" do
      get "/personal_account/main_page"
      expect(response).to redirect_to(sign_in_url)
    end
  end

end
