class Listing < ApplicationRecord
  belongs_to :user 
  has_many :reservations
  enum verified: [:false, :true]
  mount_uploader :listing_images, ImageUploader
end
