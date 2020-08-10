class ItemsController < ApplicationController

  def index
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
    @item.item_images.new

    # データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @item = Item.includes(:item_images).find(params[:id])

    grandchild_category = @item.category
    child_category = grandchild_category.parent


    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end

  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    # 選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find(params[:parent_id]).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    # 選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :brand, :category_id, :condition_id, :postage_id, :prefecture_id, :prepare_id, :price, item_images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end
end
