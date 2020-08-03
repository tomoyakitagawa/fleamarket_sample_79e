class ItemImage < ApplicationRecord
  belongs_to :item
  
  validates :image, presence: true
end
