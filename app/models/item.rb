class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images, dependent: :destroy
  belongs_to :category
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prepare
end
