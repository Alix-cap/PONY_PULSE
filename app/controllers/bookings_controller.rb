class BookingsController < ApplicationController
  before_action :set_booking, only: [:accept, :decline]
  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @pony = Pony.find(params[:pony_id])
    @booking.pony = @pony
    @booking.total_price = @pony.price_per_day * (@booking.end_date.to_date - @booking.start_date.to_date)
    if @booking.save!
      redirect_to profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @booking.update(status: "Accepted")
    redirect_to profile_path(current_user), status: :see_other
  end

  def decline
    @booking.update(status: "Declined")
    redirect_to profile_path(current_user), status: :see_other
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
