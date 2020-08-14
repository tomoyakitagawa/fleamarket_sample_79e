class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prepare
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', optional: true
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true

  accepts_nested_attributes_for :item_images, allow_destroy: true

  validates :item_images, presence: true
  validates :name, length: { maximum: 40 }, presence: true
  validates :explanation, length: { maximum: 1000 }, presence: true
  validates :category_id, :condition_id, :postage_id, :prefecture_id, :prepare_id, :seller_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }, presence: true
end
