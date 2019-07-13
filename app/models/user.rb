class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_one :adress
  # has_one :card
  # has_many :products
  # has_many :tradings
  # has_many :comments
  # has_many :likes
  # has_many :trading_products, through: :tradings
  # has_many :comment_products, through: :comments
  # has_many :like_products, through: :likes
end
