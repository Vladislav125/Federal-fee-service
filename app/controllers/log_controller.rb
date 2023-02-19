# frozen_string_literal: true

# class for authentification
class LogController < ApplicationController
  before_action :set_params, only: %i[sign_in log]
  def sign_in
    if User.find_by(login: @login).nil?
      @msg << 'This email is not registered'
      return
    end
    user = User.find_by(login: @login)
    if user.authenticate(@password)
      redirect_to_registration(user)
    else
      @msg << 'Incorrect password!'
    end
  end

  def sign_out; end

  def log
    if @commit == 'Log In'
      sign_in
    else
      set_cookie
      session[:current_user_id] = 0
      redirect_to root_path
    end
  end

  private

  def set_params
    @login = params[:login]
    @password = params[:password]
    @commit = params[:commit]
    @msg = []
  end

  def redirect_to_registration(user)
    session[:current_user_id] = user.id
    cookies[:login] = { value: session[:current_user_id], expires: (Time.now + 600) }
    redirect_to main_page_url
  end
end
