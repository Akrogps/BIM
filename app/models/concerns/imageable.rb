module Imageable
  extend ActiveSupport::Concern

  included do
    has_many :images, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :images
  end
end
