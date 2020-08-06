class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prepare

  accepts_nested_attributes_for :item_images, allow_destroy: true

  validates :name, length: { maximum: 40 }, presence: true
  validates :explanation, length: { maximum: 1000 }, presence: true
  validates :condition_id, :postage_id, :prefecture_id, :prepare_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }, presence: true

  #下記は、後ほどcategoryモデルとアソシエーションを組むときに使用します
  #belongs_to :category
end
