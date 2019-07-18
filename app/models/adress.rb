class Adress < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :postal_code,  presence: true, format: { with: /\d{3}-?\d{4}/, message: "正しい郵便番号を入力してください"}
end
