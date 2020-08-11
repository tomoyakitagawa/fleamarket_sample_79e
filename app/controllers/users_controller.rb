class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @item = Item.where(seller_id: current_user.id).length
  end
end