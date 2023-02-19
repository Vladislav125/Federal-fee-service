# frozen_string_literal: true

# class ApplicationController
class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_cookie
    if cookies[:login]
      cookies[:login] = { value: session[:current_user_id], expires: (Time.now + 600) } if session[:current_user_id]
    else
      session[:current_user_id] = nil
    end
  end

  def redirect_to_sign_in
    redirect_to sign_in_url unless cookies[:login]
  end

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    return unless I18n.available_locales.map(&:to_s).include?(parsed_locale)

    parsed_locale.to_sym
  end
end
