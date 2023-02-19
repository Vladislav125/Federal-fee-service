Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get 'personal_functions/add_income', as: 'add_income'
    post 'personal_functions/add_income_output', as: 'add_income_output'
    get 'personal_functions/add_realty', as: 'add_realty'
    post 'personal_functions/add_realty_output', as: 'add_realty_output'
    get 'personal_functions/add_vehicle', as: 'add_vehicle'
    post 'personal_functions/add_vehicle_output', as: 'add_vehicle_output'
    get 'personal_functions/payments_info', as: 'payments_info'
    get 'personal_functions/pay', as: 'pay'
    post 'personal_functions/pay_output', as: 'pay_output'
    get 'personal_functions/posession_info', as: 'posession_info'
    get 'common_actions/show_inn', as: 'show_inn'
    post 'common_actions/show_inn_output', as: 'show_inn_output'
    get 'common_actions/clear_business', as: 'clear_business'
    post 'common_actions/clear_business_output', as: 'clear_business_output'
    get 'personal_account/main_page', as: 'main_page'
    get 'log/sign_in', as: 'sign_in'
    get 'log/sign_out', as: 'sign_out'
    post 'log/log', as: 'log'
    get 'users/new', as: 'new'
    root 'homepage#index'
    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
