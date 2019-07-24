class Product < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category
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

  validates :name, presence: true, length: { maximum: 40 }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999,message: "販売価格は300以上9,999,999以内で入力してください" }
  validates :detail, presence: true, length: { maximum: 1000}
  validates :condition_id, presence: { message: "選択してください" }
  validates :delivery_fee_id, presence: { message: "選択してください" }
  validates :shipping_method_id, presence: { message: "選択してください" }
  validates :prefecture_id, presence: { message: "選択してください" }
  validates :shipping_speed_id, presence: { message: "選択してください" }
  validates :user_id, presence: true

  scope :include,  -> { includes(:images) }
  scope :limited,  -> (count) { order("created_at DESC").limit(count) }
  scope :category, -> (count) { where(category_id: count) }
end
