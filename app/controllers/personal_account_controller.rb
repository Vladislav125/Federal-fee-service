# frozen_string_literal: true

# class for personal page
class PersonalAccountController < ApplicationController
  before_action :set_cookie
  before_action :redirect_to_sign_in

  def main_page; end
end
