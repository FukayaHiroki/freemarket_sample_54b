class Product < ApplicationRecord
  belongs_to :user
  has_many :images
  accepts_nested_attributes_for :images

  has_one :trading
  has_one :trading_user, through: :tradings
  # belongs_to_active_hash :condition
end
