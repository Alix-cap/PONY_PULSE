class PoniesController < ApplicationController
  before_action :set_pony, only: [:show, :destroy]

  def show
    @booking = Booking.new
  end

  def new
    @pony = Pony.new
  end

  def create
    @pony = Pony.new(pony_params)
    @pony.user = current_user
    if @pony.save!
      redirect_to profile_path(current_user)  # update to pony_path(@pony) when available
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @ponies = Pony.all
    @markers = @ponies.geocoded.map do |pony|
      {
        lat: pony.latitude,
        lng: pony.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {pony: pony})
      }
    end
  end

  def destroy
    @pony.destroy
    redirect_to profile_path(current_user)
  end

  private

  def pony_params
    params.require(:pony).permit(:name, :race, :location, :birth_date, :sex, :purpose, :coat, :price_per_day, photos: [])
  end

  def set_pony
    @pony = Pony.find(params[:id])
  end
end
