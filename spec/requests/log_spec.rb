require 'rails_helper'

RSpec.describe "Logs", type: :request do
  describe "GET /sign_in" do
    it "returns http success" do
      get "/log/sign_in"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sign_out" do
    it "returns http success" do
      get "/log/sign_out"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /log" do
    it "returns http success" do
      post "/log/log"
      expect(response).to have_http_status(302)
    end
  end

  describe 'results' do
    before do
      User.create(login: 'login', password: '12345678', user_name: 'Иванов Иван Иванович', position: 'физичкское лицо')
    end
    it 'has good parameters' do
      post log_url, params: {commit: 'Log In', login: 'login', password: '12345678'}, xhr: true
      expect(assigns(:msg)).to eq([])
    end
    it 'has wrong login' do
      post log_url, params: {commit: 'Log In', login: 'login123', password: '12345678'}, xhr: true
      expect(assigns(:msg)).to eq(["This email is not registered"])
    end
    it 'has wrong password' do
      post log_url, params: {commit: 'Log In', login: 'login', password: 'qwerty12'}, xhr: true
      expect(assigns(:msg)).to eq(["Incorrect password!"])
    end
  end
end
