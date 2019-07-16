class Product < ApplicationRecord
  belongs_to :user
  has_many :images
  accepts_nested_attributes_for :images
  

  has_one :trading
  has_one :trading_user, through: :tradings
  accepts_nested_attributes_for :trading
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :condition
    belongs_to_active_hash :delivery
    belongs_to_active_hash :shipping
    belongs_to_active_hash :shipping_method


end
