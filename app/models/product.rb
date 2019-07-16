class Product < ApplicationRecord
  belongs_to :user
  belongs_to :large_category
  accepts_nested_attributes_for :large_category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  

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
