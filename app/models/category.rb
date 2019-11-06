class Category < ApplicationRecord
  CATEGORIES = ['Italian', 'French', 'Belgian', 'Asian', 'American']

  has_many :restaurants, through: :categories_restaurants

  validates :name, presence: true, inclusion: { in: CATEGORIES }
end
