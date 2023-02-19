# frozen_string_literal: true

# controller for actions available without registration
class CommonActionsController < ApplicationController
  before_action :set_params
  before_action :set_cookie

  def set_params
    @user_login = params[:user_name]
    @user_inn = params[:inn]
  end

  def show_inn; end

  def show_inn_output
    @user_from_db = User.find_by(login: @user_login)
    @user_from_db = nil if !@user_from_db.nil? && @user_from_db.position != 'физическое лицо'
    render turbo_stream: turbo_stream.update('show_inn_container', partial: 'show_inn_partial')
  end

  def clear_business; end

  def clear_business_output
    @user_from_db = User.find_by(inn: @user_inn)
    @user_from_db = nil if !@user_from_db.nil? && @user_from_db.position == 'физическое лицо'
    render turbo_stream: turbo_stream.update('clear_business_container', partial: 'clear_business_partial')
  end
end
