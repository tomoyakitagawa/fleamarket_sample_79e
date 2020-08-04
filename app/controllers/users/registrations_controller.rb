# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_delivery_address
    render :new_delivery_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = DeliveryAddress.new(delivery_address_params)   
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_delivery_addresss and return
    end
    @user.build_delivery_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end

  # private

  # def sign_up_user_params
  #   # birthdate = birthday_join
  #   params.require(:user).permit(:nickname, :email, :password, :password_confirmation,:family_name, :first_name, :family_name_kana, :first_name_kana, :birthdate)
  # end

  # 誕生日の送られてくるデータを「yyyy-mm-dd」の形に変換
  # def birthday_join
  #   date = params[:user]
  #   birthday = Date.new(date["birthdate(1i)"].to_i, date["birthdate(2i)"].to_i, date["birthdate(3i)"].to_i)
  #   birthday.strftime("%Y-%m-%d")
  # end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  def delivery_address_params
    params.require(:delivery_address).permit(:delivery_family_name, :delivery_first_name, :delivery_family_name_kana, :delivery_first_name_kana, :post_code, :prefecture_id, :city, :home_number, :building_name, :phone_number)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
