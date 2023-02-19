require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user with good parameters' do
    before do
      User.create!(login: 'petrov012', user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
    end

    it 'should be error if input is not unique' do
      u = User.new(login: 'petrov', user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Пользователь с таким логином уже зарегистрирован."])
    end
  end

  describe 'wrong parameters' do
    it 'has no login' do
      u = User.new(user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Введите логин.", "Недопустимый логин.", "Минимальная длина логина - 5 символов."])
    end

    it 'has wrong login' do
      u = User.new(login: 'ivan', user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Минимальная длина логина - 5 символов."])
    end

    it 'has wrong password' do
      u = User.new(login: 'petrov1', user_name: 'Петров Иван Николаевич', password: '1234567', position: 'физическое лицо')
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Минимальная длина пароля - 8 символов."])
    end

    it 'has no password' do
      u = User.new(login: 'petrov20', user_name: 'Петров Иван Николаевич', position: 'физическое лицо')
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["can't be blank", "Не введён пароль.", "Минимальная длина пароля - 8 символов."])
    end

    it 'has wrong password' do
      u = User.new(login: 'petrov3', user_name: 'Петров Иван Николаевич', password: '1234567', position: 'физическое лицо')
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Минимальная длина пароля - 8 символов."])
    end

    it 'has wrong user name' do
      u = User.new(login: 'petrov4', user_name: 'Petrov Ivan', password: '12345678', position: 'физическое лицо')
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Недопустимое имя пользователя."])
    end
  end
end
