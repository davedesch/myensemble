class OutfitsController < ApplicationController

  before_filter :authorize

  def index
    user = User.find(params[:user_id])
    outfits = Outfit.where(user_id: user.id).order('created_at DESC').limit(10)
    results = []
    outfits.each do |outfit|
      results.push({outfit_id: outfit.id, title: outfit.title, image: outfit.image_url, avg_rating: outfit.average_ratings, popularity: outfit.popularity, created_at: outfit.created_at})
    end
    render json: results
  end

  def new
    @current_user = User.find(params[:user_id])
    @outfit = Outfit.new
    5.times do
      article = @outfit.articles.build
    end
    render :new, layout: false
  end

  def create
    user = User.find(params[:user_id])
    @outfit = user.outfits.create(outfit_params)
    articles = params[:outfit][:articles_attributes]
    if articles
      articles.each do |key, value|
         @outfit.articles.create(value)
      end
    end
    redirect_to user_path(user)
  end

  def edit
    @outfit = Outfit.find(params[:id])
    render :edit, layout: false
  end

  def update
    user = User.find(params[:user_id])
    outfit = Outfit.find(params[:id])
    outfit.attributes=(outfit_params)
    outfit.save
    redirect_to user_path(user)
  end

  def destroy
    user = User.find(params[:user_id])
    outfit = Outfit.find(params[:id])
    outfit.destroy

    redirect_to "/users/#{user.id}"
  end

  private

  def outfit_params
    params.require(:outfit).permit(:image_url, :user_id, :title, :caption, :gender, :commit)
  end


end
