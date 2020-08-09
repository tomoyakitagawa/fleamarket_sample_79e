class DeliveryAddress < ApplicationRecord
  belongs_to :user, optional: true
  
  # 空の入力を防ぐ
  validates :delivery_family_name, :delivery_first_name, :delivery_family_name_kana, :delivery_first_name_kana, :post_code, :city, :home_number, presence: true
  # 同じ電話番号は登録できない
  validates :phone_number, uniqueness: true
  # 名前 全角文字のみ登録可能
  validates :delivery_family_name, :delivery_first_name, format: {with:/\A[ぁ-んァ-ン一-龥]/, message: "は全角のみで入力して下さい"}
  # 名前よみがな 全角カタカナにみ登録可能
  validates :delivery_family_name_kana, :delivery_first_name_kana, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/, message: "は全角カタカナのみで入力して下さい"}
  # 郵便番号 ハイフン抜きの7桁のみ登録可能
  validates :post_code, format: {with: /\A\d{7}\z/, message: "は「-」を除いて記入してください"}


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :prefecture_id, presence: true
end