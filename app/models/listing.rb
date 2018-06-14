class Listing < ApplicationRecord
  belongs_to :user 
  has_many :reservations
  enum verified: [:true, :false]
  mount_uploaders :listing_images, AvatarUploader
end
