class Image < ApplicationRecord
  mount_uploader :cloudinary_url, ImageUploader

  belongs_to :imageable, polymorphic: true

  validates :cloudinary_url, presence: true
end
