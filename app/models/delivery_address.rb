class DeliveryAddress < ApplicationRecord
  belongs_to :user, optional: true
  validates :delivery_family_name, :delivery_first_name, :delivery_family_name_kana, :delivery_first_name_kana, :post_code, :city, :home_number, presence: true
  # validates :post_code, format: {/^\d{3}[-]\d{4}$/}

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :prefecture_id, presence: true
end