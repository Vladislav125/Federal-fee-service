# frozen_string_literal: true

# class User
class User < ApplicationRecord
  has_secure_password
  has_many :realties, dependent: :destroy
  has_many :vehicles, dependent: :destroy

  validates :login, {
    presence: {
      message: 'Введите логин.'
    },
    uniqueness: {
      message: 'Пользователь с таким логином уже зарегистрирован.'
    },
    format: {
      with: /\A\w(\w|\d|_)*\z/,
      message: 'Недопустимый логин.'
    },
    length: {
      minimum: 5,
      message: 'Минимальная длина логина - 5 символов.'
    }
  }

  validates :password, {
    presence: {
      message: 'Не введён пароль.'
    },
    length: {
      minimum: 8,
      message: 'Минимальная длина пароля - 8 символов.'
    }
  }

  validates :user_name, {
    format: {
      with: /\A[А-Я][а-я]+( [А-Я][а-я]+)*\z/,
      message: 'Недопустимое имя пользователя.'
    }
  }

  validates :inn, {
    uniqueness: {}
  }

  before_save :set_income_tax, :set_inn

  def taxes
    result = 0
    realties = Realty.where(user_id: id)
    vehicles = Vehicle.where(user_id: id)
    result += tax
    realties.each { |object| result += object.realty_tax } unless realties.empty?
    vehicles.each { |object| result += object.vehicle_tax } unless vehicles.empty?
    result
  end

  private

  def set_income_tax
    return if income.zero?

    self.tax = if position == 'физическое лицо'
                 income * 0.13
               else
                 income * 0.16
               end
  end

  def set_inn
    loop do
      temp_inn = rand(1..9).to_s
      11.times { temp_inn += rand(0..9).to_s }
      self.inn = temp_inn
      break if valid?
    end
  end
end
