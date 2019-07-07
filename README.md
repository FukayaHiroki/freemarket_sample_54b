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
|phone|integer|null:false|


### Association
- has_one :adress
- has_one :adress
- has_many :tradings
- has_many :comments
- has_many :likes
- has_many :tradings_of_seller, class_name: 'Trading', foreign_key: 'seller_id'
- has_many :tradings_of_buyer, class_name: 'Trading', foreign_key: 'buyer_id'
- has_many :products_of_seller, through: :tradings_of_seller, source: 'product'
- has_many :products_of_buyer, through: :tradings_of_buyer, source: 'product'
- has_many :comment_products, through::comments, 
- has_many :like_products, through: :likes


## adressテーブル

|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string|null: true|
|sub_phone|integer|null: true|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user


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
|large_category_id|references|foreign_key: true|
|midium_category_id|references|foreign_key: true|
|small_category_id|references|foreign_key: true, null: true|
|size|string|null: true|
|brand_id|references|foreign_key: true, null: true|
|condition|string|null: false|
|delivery_fee|string|null: false|
|shipping_method|string|null: false|
|region_from|string|null: false|
|shipping_speed|string|null: false|
|price|integer|null: false|

### Association
- belongs_to :large_category
- belongs_to :midium_category
- belongs_to :small_category, optional: true
- belongs_to :brand, optional: true

- has_many :images
- has_one :trading
- has_many :comments
- has_many :likes
- has_one :sellers, through: :tradings
- has_one :buyers, through: :tradings
- has_many :comment_users, through::comments, 
- has_many :like_users, through: :likes


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
|seller_id|references|foreign_key: true|
|buyer_id|references|foreign_key: true|

### Association
- belongs_to : product
- belongs_to : user


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