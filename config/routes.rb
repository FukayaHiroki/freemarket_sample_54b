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
      get :email_valid
    end
    member do
      get :identification, :mycard, :mycard_create, :profile 
      post :update 
    end
    resources :cards, only: [:index, :new, :create] do
      collection  do
        post 'delete' => 'cards#delete'
      end
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

  post 'confirm',  to: 'users#confirm'
  post 'set_adress',  to: 'users#set_adress'
  post 'set_card',  to: 'users#set_card'
end
