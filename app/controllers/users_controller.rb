class UsersController < ApplicationController
  before_action :move_to_index
  before_action :move_to_mypage

  def show
    @nickname = current_user.nickname
    @user_items_count = Item.where(seller_id: current_user.id).length
  end

  private
  # ログインしていない時にマイページに入れないように制限
  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  # ログイン後、ユーザーIDが異なる場合と、@userが空の時にログインユーザーのマイページに移動させる
  def move_to_mypage
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if current_user.id != @user.id
    redirect_to user_path(current_user) if @user = nil
  end
end