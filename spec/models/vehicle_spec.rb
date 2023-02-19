require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'vehicle with good parameters' do
    it 'is right' do
      @u1 = User.create!(login: 'petrov803', user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
      v = Vehicle.new(license_plate: 'а001аа77', model: 'BMW i8', power: '500', user_id: @u1.id)
      expect(v.valid?).to be true
      expect(v.errors.objects.map(&:message)).to eq([])
    end
  end

  describe 'vehicle with wrong parameters' do
    before do

      @u = User.create!(login: 'petrov1', user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
      @v = Vehicle.create!(license_plate: 'а001аа77', model: 'BMW i8', power: '500', user_id: @u.id)   
    end

    it 'has wrong license plate' do
      v = Vehicle.new(license_plate: 'а00аа77', model: 'BMW i8', power: '500', user_id: @u.id)
      expect(v.valid?).to be false
      expect(v.errors.objects.map(&:message)).to eq(["Недопустимый номерной знак. Формат: а000аа00."])
    end

    it 'has not unique license plate' do
      v = Vehicle.new(license_plate: 'а001аа77', model: 'BMW i8', power: '500', user_id: @u.id)
      expect(v.valid?).to be false
      expect(v.errors.objects.map(&:message)).to eq(["Транспортное средство с таким номерным знаком уже зарегистрировано."])
    end

    it 'has incorrect model' do
      v = Vehicle.new(license_plate: 'а002аа77', model: '', power: '500', user_id: @u.id)
      expect(v.valid?).to be false
      expect(v.errors.objects.map(&:message)).to eq(["Некорректно указана модель транспортного средства."])
    end

    it 'has incorrect power' do
      v = Vehicle.new(license_plate: 'а002аа77', model: 'BMW i8', power: '0', user_id: @u.id)
      expect(v.valid?).to be false
      expect(v.errors.objects.map(&:message)).to eq(["Некорректно указана мощность транспортного средства."])
    end
  end
end
