class OutfitsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    p user
    outfits = Outfit.where(user_id: user.id).order('created_at DESC').limit(10)
    results = []
    outfits.each do |outfit|
      results.push({title: outfit.title, image: outfit.image_url, avg_rating: outfit.average_ratings, popularity: outfit.popularity, created_at: outfit.created_at})
    end
    render json: results
  end

  def new
    render :new, layout: false
  end

  def create
    user = User.find(params[:user_id])
    @dick = user.outfits.create(outfit_params)
    redirect_to user_path(user)
  end

  private

  def outfit_params
    params.require(:outfit).permit(:image_url, :user_id, :title, :caption, :gender, :commit)
  end

end
