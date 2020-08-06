class ItemsController < ApplicationController
  # before_action :category_parent_array, except: [:destroy] コメントアウト部分は後ほど使用なので消さないでください

  def index
    @items = Item.includes(:item_images)
  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  #def get_category_children
  #  @category_children = Category.find("#{params[:parent_id]}").children
  #end

  #def get_category_grandchildren
  #  @category_grandchildren = Category.find("#{params[:child_id]}").children
  #end

  private

  #def category_parent_array
  #  @category_parent_array = Category.where(ancestry: nil)
  #end

  def item_params
    params.require(:item).permit(:name, :explanation, :brand, :condition_id, :postage_id, :prefecture_id, :prepare_id, :price, item_images_attributes: [:image])
  end
end
