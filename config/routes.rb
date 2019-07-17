Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  devise_scope :user do
    patch 'users/:id', to: 'users/registrations#add_phone'
  end 
  
  root 'products#index'
  resources :users, only: [:show] do
    collection  do
      get 'sign_up/registration' => 'users/registrations#new'
      get 'sign_up/sms_confirmation' => 'users#sms'
      get 'sign_up/sms_confirmation/sms' => 'users#sms_confirm'
      get 'sign_up/deliver_adress' => 'users#adress'
      get 'sign_up/card' => 'users#card'
      get 'sign_up/done' => 'users#done'
      get 'new' => 'users#new'
      get :logout
    end
    member do
      get :identification, :mycard, :mycard_create, :profile 
      post :update 
    end
  end
  resources :products, except: [:edit]
  get 'products/buy/:id' => 'products#buy'

  resources :cards do
    collection  do
      post 'pay' => 'cards#pay'
    end
  end

  post 'confirm' => 'users#confirm'
  post 'set_adress' => 'users#set_adress'
  post 'set_card' => 'users#set_card'
  # view確認用仮置き
  get 'identification' => 'users#identification'
  get 'mycard' => 'users#mycard'
  get 'mycard_create' => 'users#mycard_create'
  get 'profile' => 'users#profile'
  get 'users' => 'users#show'
  get 'products/show' => 'products#show'
  get 'item/buypage'  => 'products#buypage'
end
