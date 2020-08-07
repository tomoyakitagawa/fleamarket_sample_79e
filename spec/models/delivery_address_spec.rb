require 'rails_helper'

describe DeliveryAddress do
  describe '#create' do
    # 1. delivery_family_name, delivery_first_name, delivery_family_name_kana, delivery_first_name_kana, post_code, prefecture_id, city, home_numberが存在すれば登録できること
    it "is valid with a delivery_family_name, delivery_first_name, delivery_family_name_kana, delivery_first_name_kana, post_code, prefecture_id, city, home_number " do
      delivery_address = build(:delivery_address)
      expect(delivery_address).to be_valid
    end

    # 2. delivery_family_nameが空では登録できないこと
    it "is invalid without a delivery_family_name" do
      delivery_address = build(:delivery_address, delivery_family_name: nil)
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_family_name]).to include("を入力してください")
    end

    # 3. delivery_first_nameが空では登録できないこと
    it "is invalid without a delivery_first_name" do
      delivery_address = build(:delivery_address, delivery_first_name: nil)
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_first_name]).to include("を入力してください")
    end

    # 4. delivery_family_name_kanaが空では登録できないこと
    it "is invalid without a delivery_family_name_kana" do
      delivery_address = build(:delivery_address, delivery_family_name_kana: nil)
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_family_name_kana]).to include("を入力してください")
    end

    # 5. delivery_first_name_kanaが空では登録できないこと
    it "is invalid without a delivery_first_name_kana" do
      delivery_address = build(:delivery_address, delivery_first_name_kana: nil)
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_first_name_kana]).to include("を入力してください")
    end

    # 6. post_codeが空では登録できないこと
    it "is invalid without a post_code" do
      delivery_address = build(:delivery_address, post_code: nil)
      delivery_address.valid?
      expect(delivery_address.errors[:post_code]).to include("を入力してください")
    end

    # 7. prefecture_idが空では登録できないこと
    it "is invalid without a prefecture_id" do
      delivery_address = build(:delivery_address, prefecture_id: nil)
      delivery_address.valid?
      expect(delivery_address.errors[:prefecture_id]).to include("を入力してください")
    end

    # 8. cityが空では登録できないこと
    it "is invalid without a city" do
      delivery_address = build(:delivery_address, city: nil)
      delivery_address.valid?
      expect(delivery_address.errors[:city]).to include("を入力してください")
    end

    # 9. home_numberが空では登録できないこと
    it "is invalid without a home_number" do
      delivery_address = build(:delivery_address, home_number: nil)
      delivery_address.valid?
      expect(delivery_address.errors[:home_number]).to include("を入力してください")
    end

    # 10. 重複したphone_numberが存在する場合登録できないこと
    it "is invalid with a duplicate phone_number" do
      delivery_address = create(:delivery_address)
      another_delivery_address = build(:delivery_address, phone_number: delivery_address.phone_number)
      another_delivery_address.valid?
      expect(another_delivery_address.errors[:phone_number]).to include("はすでに存在します")
    end

    # 11. post_codeが6文字以下であれば登録できないこと
    it "is invalid with a post_code that has less than 7 characters " do
      delivery_address = build(:delivery_address, post_code: "123456")
      delivery_address.valid?
      expect(delivery_address.errors[:post_code]).to include("は不正な値です")
    end

    # 12. post_codeが8文字以上であれば登録できないこと
    it "is invalid with a post_code that has more than 8 characters " do
      delivery_address = build(:delivery_address, post_code: "12345678")
      delivery_address.valid?
      expect(delivery_address.errors[:post_code]).to include("は不正な値です")
    end

    # 13. delivery_family_nameは全角のみ登録できる
    it "delivery_family_name can only be full-width" do
      delivery_address = build(:delivery_address, delivery_family_name: "aa")
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_family_name]).to include("は不正な値です")
    end

    # 14. delivery_first_nameは全角のみ登録できる
    it "delivery_first_name can only be full-width" do
      delivery_address = build(:delivery_address, delivery_first_name: "aa1")
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_first_name]).to include("は不正な値です")
    end

    # 15. delivery_family_name_kanaは全角のカタカナのみ登録できる
    it "Only full-width katakana can be registered for delivery_family_name_kana" do
      delivery_address = build(:delivery_address, delivery_family_name_kana: "あa山1ｱ")
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_family_name_kana]).to include("全角カタカナのみで入力して下さい")
    end

    # 16. delivery_first_name_kanaは全角のカタカナのみ登録できる
    it "Only full-width katakana can be registered for delivery_first_name_kana" do
      delivery_address = build(:delivery_address, delivery_first_name_kana: "あa山1ｱ")
      delivery_address.valid?
      expect(delivery_address.errors[:delivery_first_name_kana]).to include("全角カタカナのみで入力して下さい")
    end

  end
end