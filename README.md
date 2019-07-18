# DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|mail|string|null: false,unique: true|
|password|string|null:false|
|family_name|string|null:false|
|first_name|string|null:false|
|family_name_kana|string|null:false|
|first_name_kana|string|null:false|
|birthday|date|null:false|
|phone|string|null:false|


### Association
- has_one :adress
- has_one :card
- has_many :products
- has_many :tradings
- has_many :comments
- has_many :likes
- has_many :trading_products, through: :tradings
- has_many :comment_products, through: :comments
- has_many :like_products, through: :likes


## adressテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|string|null:false|
|first_name|string|null:false|
|family_name_kana|string|null:false|
|first_name_kana|string|null:false|
|postal_code|integer|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string|null: true|
|sub_phone|string|null: true|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to_active_hash :prefecture


## cardテーブル

|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|
|expiration_date|date|null: false|
|security_code|integer|null: false|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user


## productテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|index: true, null: false|
|detail|text|null: false|
|user_id|references|foreign_key: true|
|image_id|references|foreign_key: true|
|large_category_id|references|foreign_key: true|
|midium_category_id|references|foreign_key: true|
|small_category_id|references|foreign_key: true, null: true|
|size_id|integer|null: true|
|brand_id|references|foreign_key: true, null: true|
|condition_id|integer|null: false|
|delivery_fee_id|integer|null: false|
|shipping_method_id|integer|null: false|
|prefecture_id|integer|null: false|
|shipping_speed_id|integer|null: false|
|price|integer|null: false|

### Association
- belongs_to :user
- has_many :images
- belongs_to :large_category
- belongs_to :midium_category
- belongs_to :small_category, optional: true
- belongs_to :brand, optional: true
- has_one :trading
- has_many :comments
- has_many :likes
- has_one :trading_user, through: :tradings
- has_many :comment_users, through: :comments, 
- has_many :like_users, through: :likes
- belongs_to_active_hash :size, :condition, :delivery_fee, :shipping_method, :prefecture :shipping_speed


## imageテーブル

|Column|Type|Options|
|------|----|-------|
|URL|string|null: false|
|product_id|references|foreign_key: true|

### Association
- belongs_to :product


## large_categoryテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :products
- has_many :blands
- has_many :midium_categories

## medium_categoryテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|large_category_id|references|foreign_key: true|

### Association
- belongs_to : large_category
- has_many :products
- has_many :small_categories


## small_categoryテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|midium_category_id|references|foreign_key: true|

### Association
- belongs_to : midium_category
- has_many :products


## blandテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|large_category_id|references|foreign_key: true|

### Association
- belongs_to : large_category
- has_many :products


## tradingテーブル(中間)

|Column|Type|Options|
|------|----|-------|
|product_id|references|foreign_key: true|
|user_id|references|foreign_key: true|
|status_id|integer|null: false|

### Association
- belongs_to : product
- belongs_to : user
- belongs_to_active_hash :status


## commentテーブル(中間)

|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|product_id|references|foreign_key: true|
|uer_id|references|foreign_key: true|

### Association
- belongs_to : product
- belongs_to : user


## likeテーブル(中間)

|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|product_id|references|foreign_key: true|

### Association
- belongs_to : product
- belongs_to : user