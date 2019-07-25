# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  # prepend_before_action :check_captcha, only: [:create]
  # GET /users/sign_up
  def new
    super
  end

  # POST /resource
  def create
    if params['g-recaptcha-response']
      super
      SnsCredential.create(sns_params)
    else
      self.resource = resource_class.new
      respond_with_navigational(resource) { render :new }
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end



  def add_phone
    if current_user.update(phone: params[:user][:phone])
      redirect_to sign_up_sms_confirmation_sms_users_path
    else
      render template: "users/sms"
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  private
    # def check_captcha
    #   unless verify_recaptcha
    #     self.resource = resource_class.new sign_up_params
    #     resource.validate # Look for any other validation errors besides Recaptcha
    #     set_minimum_password_length
    #     respond_with resource
    #   end 
    # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday, :phone])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:phone])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    sign_up_sms_confirmation_sms_users_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    sign_up_sms_confirmation_sms_users_path
  end

  def sns_params
    params.require(:sns_credential).permit(:uid, :provider, :sns_token).merge(user_id: @user.id)
  end

  # def after_update_path_for(resource)
  #   sign_up_sms_confirmation_sms_users_path
  # end
end

