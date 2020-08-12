class ItemsController < ApplicationController

  def index
    @images = ItemImage.all
    @items = Item.limit(5)
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end
  
  def show
    @item = Item.find(params[:id])
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
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
  end

  def update
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
