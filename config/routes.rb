Rails.application.routes.draw do
  # devise_for :users
  root 'products#index'
  resources :users, only: [:show] do
    collection  do
      get 'sign_up/resistration' => 'users#registration'
      get 'sign_up/sms_confirmation' => 'users#sms'
      get 'sign_up/sms_confirmation/sms' => 'users#sms_confirm'
      get 'sign_up/deliver_adrerss' => 'users#adress'
      get 'sign_up/card' => 'users#card'
      get 'sign_up/done' => 'users#done'
      get :logout

    # 仮置きのルーティング
      get 'sign_up/' => 'users#signup'
      get 'sign_in/' => 'users#login'

    end
    member do
      get :identification, :mycard, :mycard_create, :profile 
    end
  end
  resources :products, except: [:edit]
  get 'products/buy/:id' => 'products#buy'

  # view確認用仮置き
  get 'identification' => 'users#identification'
  get 'mycard' => 'users#mycard'
  get 'mycard_create' => 'users#mycard_create'
  get 'profile' => 'users#profile'
  get 'users' => 'users#show'
end
