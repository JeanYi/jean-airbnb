class User < ApplicationRecord
  include Clearance::User
  has_many :listings, dependent: :destroy 
  has_many :reservations, dependent: :destroy 
  enum role: [:customer, :moderator, :superadmin]
  mount_uploader :image, ImageUploader
  validates :image, file_size: { less_than: 1.megabytes }
end
