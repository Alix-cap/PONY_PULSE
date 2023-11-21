class PoniesController < ApplicationController
  before_action :set_pony, only: [:show]

  def show
  end

  private

  def set_pony
    @pony = Pony.find(params[:id])
  end
end
