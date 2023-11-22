class PoniesController < ApplicationController
  before_action :set_pony, only: [:show]

  def show
  end

  def index
    @ponies = Pony.all
  end

  # def destroy
  #   @ponie.delete
  # end

  private

  def set_pony
    @pony = Pony.find(params[:id])
  end
end
