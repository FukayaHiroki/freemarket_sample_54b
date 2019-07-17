class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :adress
  has_one :card
  has_many :products
  has_many :tradings
  # has_many :comments
  # has_many :likes
  has_many :trading_products, through: :tradings
  # has_many :comment_products, through: :comments
  # has_many :like_products, through: :likes

  validates :phone, format: { with: /0[89]0-?\d{4}-?\d{4}/, message: "正しい電話番号を入力してください", on: :update}
  validates :password, length: {in: 6..128}, on: :create
  validate :date_cannot_be_in_the_future
  validates :family_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: "カタカナで入力して下さい"}
  validates :first_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: "カタカナで入力して下さい"}

  def date_cannot_be_in_the_future
    if birthday.present? && birthday >= Date.today
      errors.add(:date, ": 正しい日付を入力してください")
    end
  end   
  
end
