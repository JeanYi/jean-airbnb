class Listing < ApplicationRecord
  belongs_to :user 
  has_many :reservations, dependent: :destroy 
  enum verified: [:false, :true]
  mount_uploaders :listing_images, ImageUploader
  validates :listing_images, file_size: { less_than: 3.megabytes }
  monetize :price_cents
end
