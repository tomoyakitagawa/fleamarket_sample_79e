require 'rails_helper'
describe User do
  describe '#create' do
    it "ニックネームが空だと登録できない" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "メールアドレスが空だと登録できない" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "パスワードが空だと登録できない" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "性が空だと登録できない" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end

    it "名が空だと登録できない" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "性カナが空だと登録できない" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end

    it "名カナが空だと登録できない" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    it "パスワードと確認パスワードが一致していないと登録できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "パスワードが7文字以上で登録できる" do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    it "パスワードが7文字未満だと登録できない" do
      user = build(:user, password: "sample")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end
  end

  describe '#名前を半角で入力' do
    it '性を半角で入力した時登録できない' do
      user = build(:user, family_name: "ﾐｮｳｼﾞ")
      user.valid?
      expect(user.errors[:family_name]).to include("は全角で入力してください")
    end
 
    it '名を半角で入力した時登録できない' do
      user = build(:user, first_name: "ﾅﾏｴ")
      user.valid?
      expect(user.errors[:first_name]).to include("は全角で入力してください")
    end
  end

  describe '#フリガナをカタカナ意外で入力' do
    it '性カナをカタカナ意外で入力した時登録できない' do
      user = build(:user, family_name_kana: "kana")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は全角カナで入力してください")
    end
 
    it '名カナをカタカナ意外で入力した時登録できない' do
      user = build(:user, first_name_kana: "kana")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は全角カナで入力してください")
    end
  end
end