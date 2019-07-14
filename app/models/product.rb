class Product < ApplicationRecord
  belongs_to :user
  has_many :image
  has_one :trading
  has_one :trading_user, through: :tradings

end
