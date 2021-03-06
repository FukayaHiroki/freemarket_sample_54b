class UsersController < ApplicationController
  protect_from_forgery except: [:confirm, :set_card]
  before_action :back_to_sign, only: [:show, :profile, :identification, :mycard, :mycard_create, :logout, :adress, :card, :done] 
  before_action :redirect_to_root, only: [:facebook, :google, :sms]

  require "payjp"
  def show
    @category = Category.all
  end

  def profile
    @category = Category.all
  end

  def edit
  end

  def logout
    @category = Category.all
  end
  
  def mycard
    @category = Category.all
  end

  def mycard_create
  end
  
  def email_valid
    @user = User.find_by(email: params[:email])
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def facebook
    @user = User.new
    @sns_credemtial
  end 

  def google
    @user = User.new
    @sns_credemtial
  end

  def sms
    @user = User.new
    @sns_credential = SnsCredential.new
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
    Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
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
    @category = Category.all
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

  def redirect_to_root
    redirect_to root_path if user_signed_in?
  end

end
