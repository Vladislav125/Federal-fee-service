# frozen_string_literal: true

# class Realty
class Realty < ApplicationRecord
  belongs_to :user

  validates :address, {
    presence: {
      message: 'Недопустимый адрес.'
    },
    uniqueness: {
      message: 'Недвижимость с таким адресом уже зарегистрирована.'
    }
  }

  validates :square, {
    format: {
      with: /\A[1-9]\d*\z/,
      message: 'Недопустимая площадь.'
    }
  }

  validates :cost, {
    format: {
      with: /\A[1-9]\d*\z/,
      message: 'Недопустимая стоимость.'
    }
  }

  before_save :set_tax

  private

  def set_tax
    self.realty_tax = if square > 20
                        (cost - cost * 20 / square) * 0.001
                      else
                        cost * 0.001
                      end
  end
end
