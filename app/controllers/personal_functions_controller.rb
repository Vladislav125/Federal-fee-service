# frozen_string_literal: true

# class for personal actions
class PersonalFunctionsController < ApplicationController
  before_action :set_cookie
  before_action :redirect_to_sign_in
  before_action :set_common_params
  before_action :set_params_income, only: :add_income_output
  before_action :set_params_realty, only: :add_realty_output
  before_action :set_params_vehicle, only: :add_vehicle_output
  before_action :set_params_pay, only: :pay_output

  def add_income; end

  def add_income_output
    if @income.match?(/\A[1-9]\d*\z/)
      @income = @income.to_i
      @current_user.update_column(:income, @income)
      @current_user.update_column(:tax, @income * 0.13)

      render turbo_stream: turbo_stream.update('add_income_container', partial: 'add_income_partial')
    else
      @error << 'Сумма введена некорректно'
    end
  end

  def add_realty; end

  def add_realty_output
    @new_realty = Realty.new(user_id: session[:current_user_id], address: @address, square: @square.to_i,
                             cost: @cost.to_i)
    if @new_realty.valid?
      @new_realty.save
    else
      @new_realty.errors.objects.map(&:message).each { |msg| @error << msg }
    end
    render turbo_stream: turbo_stream.update('add_realty_container', partial: 'add_realty_partial')
  end

  def add_vehicle; end

  def add_vehicle_output
    @new_vehicle = Vehicle.new(user_id: session[:current_user_id], license_plate: @license_plate, model: @model,
                               power: @power)
    if @new_vehicle.valid?
      @new_vehicle.save
    else
      @new_vehicle.errors.objects.map(&:message).each { |msg| @error << msg }
    end
    render turbo_stream: turbo_stream.update('add_vehicle_container', partial: 'add_vehicle_partial')
  end

  def payments_info; end

  def pay
    @tax_to_pay = @current_user.taxes - @current_user.tax_payed
    @tax_to_pay = 0 if @tax_to_pay.negative?
  end

  def pay_output
    if @sum.match?(/\A[1-9]\d*\z/)
      @sum = @sum.to_i
      @tax_payed = @current_user.tax_payed + @sum
      @current_user.update_column(:tax_payed, @tax_payed)
    else
      @error << 'Некорректно введена сумма'
    end
    render turbo_stream: turbo_stream.update('pay_container', partial: 'pay_partial')
  end

  def posession_info; end

  private

  def set_common_params
    @current_user = User.find_by(id: session[:current_user_id])
    @error = []
  end

  def set_params_income
    @income = params[:income]
  end

  def set_params_realty
    @address = params[:address]
    @square = params[:square]
    @cost = params[:cost]
  end

  def set_params_vehicle
    @license_plate = params[:license_plate]
    @model = params[:model]
    @power = params[:power]
  end

  def set_params_pay
    @sum = params[:sum]
  end
end
