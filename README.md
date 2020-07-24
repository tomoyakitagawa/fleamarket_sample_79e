## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_many :user_evaluations
- has_many :seller_items, class_name: 'item', foreign_key: 'seller_id'
- has_many :buyer_items, class_name: 'item', foreign_key: 'buyer_id'
- belongs_to :profile, dependent: :destroy
- belongs_to :credit_card, dependent: :destroy
- belongs_to :delivery_address, dependent: :destroy

## profilesテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|date|null: false|
|birth_month|date|null: false|
|birth_day|date|null: false|
|avatar|string||
|introduction|text||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|credit_number|integer|null: false, unique: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## delivery_addressテーブル
|Column|Type|Options|
|------|----|-------|
|delivery_family_name|string|null: false|
|delivery_first_name|string|null: false|
|delivery_family_name_kana|string|null: false|
|delivery_first_name_kana|string|null: false|
|post_code|integer(7)|null: false|
|prefecture_id|references|null: false, foreign_key: true|
|city|string|null: false|
|home_number|string|null: false|
|building_name|string||
|phone_number|integer|unique: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to_active_hash :prefecture

## user_evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|review|text|null: false|
|evaluation_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to_active_hash :evaluation
- belongs_to :item

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|explanation|text|null: false|
|category_id|references|null: false, foreign_key: true|
|clothes_size_id|references|null: false, foreign_key: true|
|brand_id|references|foreign_key: true|
|item_condition_id|references|null: false, foreign_key: true|
|postage_id|references|null: false, foreign_key: true|
|shipping_method_id|references|null: false, foreign_key: true|
|prefecture_id|references|null: false, foreign_key: true|
|shipping_days_id|references|null: false, foreign_key: true|
|price|integer|null: false|
|seller_id|references|null: false, foreign_key: true|
|buyer_id|references|foreign_key: true|
|status_id|references|null: false, foreign_key: true|

### Association
- has_many :item_images, dependent: :destroy
- belongs_to :user_evaluation
- belongs_to_active_hash :prefecture
- belongs_to :category
- belongs_to_active_hash :clothes_size
- belongs_to :brand
- belongs_to_active_hash :item_condition
- belongs_to_active_hash :postage
- belongs_to_active_hash :shipping_method
- belongs_to_active_hash :shipping_days
- belongs_to_active_hash :status
- belongs_to :seller, class_name: 'user', foreign_key: 'seller_id'
- belongs_to :buyer, class_name: 'user', foreign_key: 'buyer_id'

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## categoriesテーブル(gem ancestryを使用)
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||

### Association
- has_many :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items