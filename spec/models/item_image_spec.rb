require 'rails_helper'

describe ItemImage do
  describe '#create' do

    it "必要事項が埋まっていれば画像を登録できる" do
      item_image = build(:item_image)
      expect(item_image).to be_valid
    end

    it "imageカラムが空の場合は画像を登録できない" do
      item_image = build(:item_image, image: "")
      item_image.valid?
      expect(item_image.errors[:image]).to include("を入力してください")
    end

    it "item_idが空の場合は画像を登録できない" do
      item_image = build(:item_image, item_id: nil)
      item_image.valid?
      expect(item_image.errors[:item]).to include("を入力してください")
    end
  end
end