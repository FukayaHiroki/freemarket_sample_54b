Rails.application.routes.draw do #オーバーライドにともなって、使用するコントローラーの場所を指定
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks" 
  }
  devise_scope :user do #deviseにアクション追加
    patch 'users/:id', to: 'users/registrations#add_phone'
  end 
  
  root 'products#index'
  resources :users, only: [:show, :edit] do
    collection  do
      get 'sign_up/registration',  to: 'users/registrations#new'
      get 'sign_up/facebook', to: 'users#facebook'
      get 'sign_up/google', to: 'users#google'
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
  end
  resources :cards, only: [:index, :new, :create] do
    collection  do
      post 'delete' => 'cards#delete'
    end
  end
  resources :products
  get 'products/buy/:id' => 'products#buy'

  post 'confirm',  to: 'users#confirm'
  post 'set_adress',  to: 'users#set_adress'
  post 'set_card',  to: 'users#set_card'
  
  # view確認用仮置き
  get 'identification',  to: 'users#identification'
  get 'mycard',  to: 'users#mycard'
  get 'mycard_create',  to: 'users#mycard_create'
  get 'profile',  to: 'users#profile'
  get 'users',  to: 'users#show'
  get 'products/show',  to: 'products#show'
  get 'item/buypage' ,  to: 'products#buypage'
end
