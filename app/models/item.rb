class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images, dependent: :destroy #後でdependent: :destroyは削除する
  has_many :categories
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prepare

  validates :name, length: { maximum: 40 }, presence: true
  validates :explanation, length: { maximum: 1000 }, presence: true
  validates :category, :condition_id, :postage_id, :prefecture_id, :prepare_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }, presence: true
end
