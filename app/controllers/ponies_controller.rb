class PoniesController < ApplicationController
  before_action :set_pony, only: [:show, :destroy]

  def show
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
  end

  def destroy
    @pony.destroy
    redirect_to profile_path(current_user)
  end

  private

  def set_pony
    @pony = Pony.find(params[:id])
  end

  def pony_params
    params.require(:pony).permit(:name, :race, :location, :birth_date, :sex, :purpose, :coat, :price_per_day, photos: [])
  end
end
