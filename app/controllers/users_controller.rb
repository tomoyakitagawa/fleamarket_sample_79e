class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @user_items_count = Item.where(seller_id: current_user.id).length
  end
end