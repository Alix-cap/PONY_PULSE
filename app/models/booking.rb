class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pony

  validates :start_date, :end_date, :user_id, :pony_id, :status, :total_price, presence: true
  validate :start_date_after_time_now
  validate :end_date_after_start_date

  private

  def start_date_after_time_now
    errors.add(:start_date, "You cannot book a poney in the past. Please define a new start date") if start_date < Date.today
  end

  def end_date_after_start_date
    errors.add(:end_date, "End date must be after start date. Please define a new end date.") if end_date < start_date
  end
end
