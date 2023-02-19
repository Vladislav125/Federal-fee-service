require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'GET /' do
    context 'Should return right results on homepage' do
      before do
        User.create(login: 'petrov', user_name: 'Петров Иван Николаевич', password: '12345678', position: 'физическое лицо')
        User.create(login: 'podryad', user_name: 'Подряд', password: '12345678', position: 'юридическое лицо')
      end

      scenario 'success while registration' do
        visit new_user_path
        fill_in :user_login, with: 'login9'
        fill_in :user_user_name, with: 'Васильев Роман Иванович'
        fill_in :user_password, with: 'qwerty12'
        fill_in :user_password_confirmation, with: 'qwerty12'
        find('#log_button').click
        sleep(0.1)
        expect(current_path).to eq '/en/users/7'
      end

      scenario 'check show inn' do
        visit root_path
        find("#get_inn_btn").click
        sleep(0.1)
        expect(current_path).to eq '/en/common_actions/show_inn'
        sleep(0.1)
        fill_in :user_name, with: 'petrov'
        find("#show_user_inn").click
        expect(current_path).to eq '/en/common_actions/show_inn'
        expect(find('#show_inn_container')).to have_text("INN of individual Петров Иван Николаевич: #{User.find_by(login: 'petrov').inn}")
      end

      scenario 'check clear business' do
        visit root_path
        find("#clear_business_btn").click
        sleep(0.1)
        expect(current_path).to eq '/en/common_actions/clear_business'
        sleep(0.1)
        fill_in :inn, with: User.find_by(login: 'podryad').inn
        find("#clear_business_show").click
        expect(current_path).to eq '/en/common_actions/clear_business'
        expect(find('#clear_business_container')).to have_text("\"Подряд\"\nINN #{User.find_by(login: 'podryad').inn}")
      end

      scenario 'results after success login' do
        visit '/log/sign_in'
        fill_in :login, with: 'petrov'
        fill_in :password, with: '12345678'
        find('#auth_btn').click
        sleep(0.1)
        visit root_path
        find('#lk_button').click
        sleep(1)
        expect(current_path).to eq('/en/personal_account/main_page')
      end

      scenario 'check input income' do
        visit '/log/sign_in'
        fill_in :login, with: 'petrov'
        fill_in :password, with: '12345678'
        find('#auth_btn').click
        sleep(0.1)
        visit root_path
        find('#lk_button').click
        sleep(1)
        visit '/personal_account/main_page'
        expect(current_path).to eq('/personal_account/main_page')
        find('#add_income').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/add_income')      
        fill_in :income, with: 1300000
        find('#add_income_button').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/add_income')      
        expect(find('#add_income_container')).to have_text("Your information saved\nIncome tax: 169000.0")
      end

      scenario 'check input vehicle' do
        visit '/log/sign_in'
        fill_in :login, with: 'petrov'
        fill_in :password, with: '12345678'
        find('#auth_btn').click
        sleep(0.1)
        visit '/personal_account/main_page'
        expect(current_path).to eq('/personal_account/main_page')
        find('#add_income').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/add_income')      
        fill_in :income, with: 1300000
        find('#add_income_button').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/add_income')      
        expect(find('#add_income_container')).to have_text("Your information saved\nIncome tax: 169000.0")
        visit '/personal_account/main_page'
        find('#add_vehicle').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/add_vehicle')
        fill_in :license_plate, with: 'а123аа25'
        fill_in :model, with: 'BMW 3 series'
        fill_in :power, with: 500
        find('#add_vehicle_button').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/add_vehicle')      
        expect(find('#add_vehicle_container')).to have_text("Your information saved\nTax on this vehicle 75000")
        visit '/personal_account/main_page'
        find('#add_realty').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/add_realty')
        fill_in :address, with: 'Москва, Измайловский проспект 73, 321'
        fill_in :square, with: 120
        fill_in :cost, with: 3000000
        find('#add_realty_button').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/add_realty')      
        expect(find('#add_realty_container')).to have_text("Your information saved\nTax on this realty 2500")
        visit '/personal_account/main_page'
        find('#pay').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/pay')    
        fill_in :sum, with: 12000
        find('#pay_button').click 
        expect(find('#pay_container')).to have_text("You paid 12000 ₽")
        visit '/personal_account/main_page'
        find('#payments').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/payments_info')     
        expect(find('#payments_container')).to have_text("Common taxes sum 246500 ₽\nPaid sum 12000 ₽\nYou need to pay tax of 234500 ₽")
        visit '/personal_account/main_page'
        find('#possession_info').click
        sleep(0.1)
        expect(current_path).to eq('/en/personal_functions/posession_info')             
      end
    end
  end
end
