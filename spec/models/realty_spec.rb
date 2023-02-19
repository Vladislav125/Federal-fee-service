require 'rails_helper'

RSpec.describe Realty, type: :model do
  describe 'realty with good parameters' do
    it 'is right' do
      @u1 = User.create!(login: 'petrov80', user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
      r = Realty.new(address: 'Москва, Ленинский проспект 73, 25', square: '100', cost: '10000000', user_id: @u1.id)
      expect(r.valid?).to be true
      expect(r.errors.objects.map(&:message)).to eq([])
    end
  end

  describe 'realty with wrong parameters' do
    before do
      @u = User.create!(login: 'petrov1', user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
      @r = Realty.create!(address: 'Москва, Ленинский проспект 73, 25', square: '100', cost: '10000000', user_id: @u.id)
    end

    it 'has no address' do
      r = Realty.new(address: '', square: '100', cost: '10000000', user_id: @u.id)
      expect(r.valid?).to be false
      expect(r.errors.objects.map(&:message)).to eq(["Недопустимый адрес."])
    end

    it 'has not unique address' do
      r = Realty.new(address: 'Москва, Ленинский проспект 73, 25', square: '100', cost: '10000000', user_id: @u.id)
      expect(r.valid?).to be false
      expect(r.errors.objects.map(&:message)).to eq(["Недвижимость с таким адресом уже зарегистрирована."])
    end

    it 'has incorrect square' do
      r = Realty.new(address: 'Москва, Ленинский проспект 73, 27', square: '0', cost: '10000000', user_id: @u.id)
      expect(r.valid?).to be false
      expect(r.errors.objects.map(&:message)).to eq(["Недопустимая площадь."])
    end

    it 'has incorrect cost' do
      r = Realty.new(address: 'Москва, Ленинский проспект 73, 29', square: '100', cost: '0', user_id: @u.id)
      expect(r.valid?).to be false
      expect(r.errors.objects.map(&:message)).to eq(["Недопустимая стоимость."])
    end
  end
end
