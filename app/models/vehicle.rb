# frozen_string_literal: true

# class Vehicle
class Vehicle < ApplicationRecord
  belongs_to :user

  validates :license_plate, {
    uniqueness: {
      message: 'Транспортное средство с таким номерным знаком уже зарегистрировано.'
    },
    format: {
      with: /\A[авекмнорстух]\d{3}[авекмнорстух]{2}(\d{2}|\d{3})\z/,
      message: 'Недопустимый номерной знак. Формат: а000аа00.'
    }
  }

  validates :model, {
    presence: {
      message: 'Некорректно указана модель транспортного средства.'
    }
  }

  validates :power, {
    format: {
      with: /\A[1-9]\d*\z/,
      message: 'Некорректно указана мощность транспортного средства.'
    }
  }

  before_save :set_tax

  private

  def set_tax
    self.vehicle_tax = power * quote
  end

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
  def quote
    case power
    when (1..100)
      12
    when (101..125)
      25
    when (126..150)
      35
    when (151..175)
      45
    when (176..200)
      50
    when (201..225)
      65
    when (226..250)
      75
    else
      150
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity
end
