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


  with_options on: :create do |create|
    create.validates :nickname, presence: true
    create.validates :email, presence: true, uniqueness: true
    create.validates :password, presence: true, length: {in: 6..128}
    create.validates :family_name, presence: true
    create.validates :first_name, presence: true
    create.validates :family_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: "カタカナで入力して下さい"}
    create.validates :first_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: "カタカナで入力して下さい"}
    create.validate  :date_cannot_be_in_the_future
    create.validates :birthday, presence: true
    create.validates :phone, presence: true, format: { with: /0[89]0-?\d{4}-?\d{4}/, message: "正しい電話番号を入力してください"}
  end

  def date_cannot_be_in_the_future
    if birthday.present? && birthday >= Date.today
      errors.add(:date, ": 正しい日付を入力してください")
    end
  end   
  
end
