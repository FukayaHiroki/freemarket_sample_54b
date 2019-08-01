class Adress < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :postal_code,  presence: true, format: { with: /\d{3}-?\d{4}/, message: "正しい郵便番号を入力してください"}
  validates :family_name,  presence: true
  validates :first_name,  presence: true
  validates :family_name_kana,  presence: true
  validates :first_name_kana,  presence: true
  validates :prefecture_id,  presence: true
  validates :city,  presence: true
  validates :block,  presence: true
end
