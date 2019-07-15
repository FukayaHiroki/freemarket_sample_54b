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
end
