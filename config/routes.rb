Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    patch 'users/:id', to: 'users/registrations#add_phone'
  end 
  
  root 'products#index'
  resources :users, only: [:show, :edit] do
    collection  do
      get 'sign_up/registration',  to: 'users/registrations#new'
      get 'sign_up/sms_confirmation',  to: 'users#sms'
      get 'sign_up/sms_confirmation/sms',  to: 'users#sms_confirm'
      get 'sign_up/deliver_adress',  to: 'users#adress'
      get 'sign_up/card',  to: 'users#card'
      get 'sign_up/done',  to: 'users#done'
      get 'new',  to: 'users#new'
      get :logout
    end
    member do
      get :identification, :mycard, :mycard_create, :profile 
      post :update 
    end
  end

  resources :products do
    member  do
      get  'buy'      => 'products#buy'
      get  'buy/done' => 'products#done'
      post 'pay'      => 'products#pay'
    end
    collection do
      get 'get_category_children', defaults: { format: 'json'}
      get 'get_category_grandchildren', defaults: { format: 'json'}
    end
    resources :comments, only: [:create]
  end
  resources :cards, only: [:index, :new, :create] do
    collection  do
      post 'delete' => 'cards#delete'
    end
  end
  post 'confirm',  to: 'users#confirm'
  post 'set_adress',  to: 'users#set_adress'
  post 'set_card',  to: 'users#set_card'
  
  # view確認用仮置き
  get 'identification',  to: 'users#identification'
  get 'profile',  to: 'users#profile'
  get 'users',  to: 'users#show'
end
