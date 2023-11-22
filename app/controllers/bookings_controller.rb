class BookingsController < ApplicationController

  # def new
  #   @pony = Pony.new
  # end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save!
      redirect_to pony_path(@pony)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to booking_path, status: :see_other
  end



  private

  # def set_pony
  #   @pony = Pony.find(params[:id])
  # end

  # def pony_params
  #   params.require(:pony).permit(:name, :race, :location, :birth_date, :sex, :purpose, :coat, :price_per_day, photos: [])
  # end
end


end
