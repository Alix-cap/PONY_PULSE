class PagesController < ApplicationController
  def home
  end

  def profile
    @user = current_user
    @ponies = @user.ponies
  end
end
