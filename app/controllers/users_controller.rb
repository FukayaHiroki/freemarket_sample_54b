class UsersController < ApplicationController
  protect_from_forgery except: [:confirm, :set_card]
  before_action :back_to_sign, only: [:show, :profile, :identification, :mycard, :mycard_create, :logout] 

  require "payjp"
  
  def profile
  end

  def mycard
  end

  def mycard_create
  end
  
  def sms
  end

  def sms_confirm
  end

  def confirm
    num = params[:confirm]
    unless params[:confirm] == "" 
      redirect_to sign_up_deliver_adress_users_path
    else 
      render :sms_confirm
    end
  end

  def update
    current_user.update(phone: params[:phone])
  end


  def adress
    @adress = Adress.new
  end

  def set_adress
    @adress = Adress.new(adress_params)
    if @adress.save
      redirect_to sign_up_card_users_path
    else
      render :adress
    end
  end

  def card
    @card = Card.new(user_id: current_user.id)
  end

  def set_card
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.create(card: params['payjp_token']) #念の為metadataにuser_idを入れましたがなくてもOK
    @card = Card.create(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
    redirect_to sign_up_done_users_path
end

  def done
  end

# 仮置きのアクション
  def signup
  end

  def login
  end

  def identification
  end


  private
  def adress_params
    params.require(:adress).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :prefecture_id, :city, :block, :building).merge(user_id: current_user.id)
  end

  def back_to_sign
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end
