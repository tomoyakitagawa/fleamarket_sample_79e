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
    @user = User.new(sign_up_user_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    if @user.save
      redirect_to root_path
    else
      render :new and return
    end
    # session["devise.regist_data"] = {user: @user.attributes}
    # session["devise.regist_data"][:user]["password"] = params[:user][:password]
    # @address = @user.build_address
    # render :new_address
  end

  private
  def sign_up_user_params
    brithdate = birthday_join
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation,:family_name, :first_name, :family_name_kana, :first_name_kana).merge(brithdate: brithdate)
  end

  # 誕生日の送られてくるデータを「yyyy-mm-dd」の形に変換
  def birthday_join
    date = params[:user]

    if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
      return
    end

    birthday = Date.new(date["birthday(1i)"].to_i, date["birthday(2i)"].to_i, date["birthday(3i)"].to_i)
    birthday.strftime("%Y-%m-%d")
  end
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

  # protected

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
