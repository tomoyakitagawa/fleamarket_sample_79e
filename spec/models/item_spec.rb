require 'rails_helper'

describe Item, type: :model do
  describe '#create' do

    it "必要事項が入力されていれば出品できる" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "is invalid without a name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "nameが41文字以上だと出品できない" do
      item = build(:item, name: "a" * 41)
      item.valid?
      expect(item.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "is invalid without a explanation" do
      item = build(:item, explanation: "")
      item.valid?
      expect(item.errors[:explanation]).to include("を入力してください")
    end

    it "explanationが1001文字以上だと出品できない" do
      item = build(:item, explanation: "a" * 1001)
      item.valid?
      expect(item.errors[:explanation]).to include("は1000文字以内で入力してください")
    end

    it "is invalid without a category_id" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    it "is invalid without a condition_id" do
      item = build(:item, condition_id: "")
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "is invalid without a postage_id" do
      item = build(:item, postage_id: "")
      item.valid?
      expect(item.errors[:postage_id]).to include("を入力してください")
    end

    it "is invalid without a prefecture_id" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "is invalid without a prepare_id" do
      item = build(:item, prepare_id: "")
      item.valid?
      expect(item.errors[:prepare_id]).to include("を入力してください")
    end

    it "is invalid without a price" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "priceが299円以下だと出品できない" do
      item = build(:item, price: 299)
      item.valid?
      expect(item.errors[:price]).to include("は300以上の値にしてください")
    end

    it "priceが10000000円以上だと出品できない" do
      item = build(:item, price: 10000000)
      item.valid?
      expect(item.errors[:price]).to include("は9999999以下の値にしてください")
    end

    it "is invalid without a seller_id" do
      item = build(:item, seller_id: "")
      item.valid?
      expect(item.errors[:seller_id]).to include("を入力してください")
    end

  end
end