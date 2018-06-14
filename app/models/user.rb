class User < ApplicationRecord
  include Clearance::User
  has_many :listings
  has_many :reservations
  enum role: [:customer, :moderator, :superadmin]
  mount_uploader :image, AvatarUploader
end
