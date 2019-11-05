class Booking < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :participants, presence: true, inclusion: { in: [1, 2, 3, 4, 5, 6, 7, 8] }
  validates :date, presence: true
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    errors.add(:date, "You cannot book a restaurant in the past") if !date.blank? && date < Date.today
  end
end
