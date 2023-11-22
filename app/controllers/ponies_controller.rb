class PoniesController < ApplicationController
  before_action :set_pony, only: [:show]

  def show
  end

  def new
    @pony = Pony.new
  end

  def create
    @pony = Pony.new(pony_params)
    @pony.user = current_user
    if @pony.save!
      redirect_to root_path  # update to pony_path(@pony) when available
    else
      render :new, status: :unprocessable_entity
    end

  def index
    @ponies = Pony.all
  end

  private

  def set_pony
    @pony = Pony.find(params[:id])
  end

  def pony_params
    params.require(:pony).permit(:name, :race, :location, :birth_date, :sex, :purpose, :coat, :price_per_day, photos: [])
  end
end
