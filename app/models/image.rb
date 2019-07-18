class Image < ApplicationRecord
  mount_uploader :url, ImageUploader
  belongs_to :product, optional: true

  validates :url, presence: true
  validates :product_id, presence: true
end
