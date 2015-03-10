class RatingsController < ApplicationController

  def new
    # form is hidden in front end
  end

  def create
    user = User.find(params[:user_id])
    outfit = Outfit.find(params[:outfit_id])
    r = Rating.create(rating_params)
    p r.errors
    redirect_to user_path(user)
  end

  private

  def rating_params
    params.require(:rating).permit(:user_id, :outfit_id, :comment, :stars)
  end
end
