class PagesController < ApplicationController
  def home
  end

  def profile
    @user = current_user
    @ponies = @user.ponies
    @bookings_to_validate = Booking.where(pony: @ponies)
  end
end
