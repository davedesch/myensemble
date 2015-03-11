class UsersController < ApplicationController

  def index
    render :index
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      redirect_to '/register'
    end
  end

  def show
    @user_id = session[:user_id]
    render :dashboard
  end

  def ensembles
    outfits = Outfit.order('created_at DESC').limit(50)
    results = []
    outfits.each do |outfit|
      types = []
      outfit.articles.each do |article|
        types.push(article.article_type.type_desc)
      end
      ratings = []
      outfit.ratings.each do |rating|
        ratings.push({comment: rating.comment, stars: rating.stars, username: rating.user.username})
      end
      results.push({outfit_id: outfit.id , title: outfit.title , image: outfit.image_url, types: types, avg_rating: outfit.average_ratings, caption: outfit.caption, user: outfit.user.username, popularity: outfit.popularity, created_at: outfit.created_at, ratings: ratings})
    end
    render json: results
  end




  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_digest, :avatar)
  end


end
