Rails.application.routes.draw do
  # devise_for :users
  root 'products#index'
  resources :users, only: [:show] do
    collection  do
      get 'sign_up/resistration' => 'user#registration'
      get 'sign_up/sms_confirmation' => 'user#sms'
      get 'sign_up/sms_confirmation/sms' => 'users#sms_confirm'
      get 'sign_up/deliver_adrerss' => 'users#adress'
      get 'sign_up/card' => 'users#card'
      get 'sign_up/done' => 'users#done'
      get :logout
    end
    member do
      get :identification, :mycard, :mycard_create, :profile 
    end
  end
  resources :products, except: [:edit]
  get 'products/buy/:id' => 'products#buy'
end
