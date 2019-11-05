class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :cloudinary_url, presence: true
end
