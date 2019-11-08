class Restaurant < ApplicationRecord
  searchkick locations: [:location], word_start: [:name]

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :categories, through: :categories_restaurants

  include Imageable

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
  validates :description, presence: true
  validates :content, presence: true
  validates :website, format: { with: /https?:\/\/[\S]+/ }, allow_blank: true
  validates :opening_hours, presence: true

  def search_data
    attributes.merge(location: {lat: latitude, lon: longitude})
  end
end
