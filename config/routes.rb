Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  root 'products#index'
  resources :users, only: [:show] do
    collection  do
      get 'sign_up/registration' => 'users#registration'
      get 'sign_up/sms_confirmation' => 'users#sms'
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

  # view確認用仮置き
  get 'identification' => 'users#identification'
  get 'mycard' => 'users#mycard'
  get 'mycard_create' => 'users#mycard_create'
  get 'profile' => 'users#profile'
  get 'users' => 'users#show'
  get 'sign_up' => 'users#signup'
  get 'sign_in' => 'users#login'
  get 'products/show' => 'products#show'

end
