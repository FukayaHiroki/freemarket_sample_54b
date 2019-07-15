class UsersController < ApplicationController
  protect_from_forgery except: :confirm

  def mycard
  end

  def mycard_create
  end
  
  def registration
    @user = User.new
  end

  def sms
    @user = current_user
  end

  def sms_confirm
  end

  def confirm
    num = params[:confirm]
    unless params[:confirm] == ""
      redirect_to sign_up_deliver_adrerss_users_path
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
end
