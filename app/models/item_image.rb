class ItemImage < ApplicationRecord
  belongs_to :item
  mount_uploader :image, ItemImageUploader
  
  validates :image, presence: true
end
