class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @pony = Pony.find(params[:pony_id])
    @booking.pony = @pony
    @booking.total_price = @pony.price_per_day * (@booking.end_date - @booking.start_date)
    if @booking.save!
      redirect_to profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  # end

  # def update
  #   if @booking.update(booking_params)
  #     redirect_to booking_path(@booking)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @booking.destroy
  #   redirect_to booking_path, status: :see_other
  # end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
