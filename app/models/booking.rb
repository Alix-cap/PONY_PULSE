class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pony

  validates :start_date, :end_date, :user_id, :pony_id, :status, :total_price, presence: true
end
