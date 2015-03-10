class FavoritesController < ApplicationController

  def hashtags
    # this is just a list of the users favorite hashtags for the drop down
    user = User.find(session[:user_id])
    hashtags = user.favorites.where(fave_type: "Hashtag")
    render json: hashtags
  end

  def outfits
    # all outfits from the users favorite outfits
    user = User.find(session[:user_id])
    outfits = user.favorites.where(fave_type: "Outfits")
    results = []
    outfits.each do |outfit|
      types = []
      outfit.articles each do |article|
        types.push(article.article_type.type_desc)
      end
      results.push({outfit_id: outfit.id , title: outfit.title , image: outfit.image_url, types: types, avg_rating: outfit.average_ratings, caption: outfit.caption, user: outfit.user.username, popularity: outfit.popularity, created_at: outfit.created_at})
    end
    render json: results

  end

  def articles
    # all outfits with the users favorite articles
    user = User.find(session[:user_id])
    articles = user.favorites.where(fave_type: "Articles")
    outfits = []
    articles.each do |article|
      outfits.push(article.outfit)
    end
    results = []
    outfits.each do |outfit|
      types = []
      outfit.articles each do |article|
        types.push(article.article_type.type_desc)
      end
      results.push({outfit_id: outfit.id , title: outfit.title , image: outfit.image_url, types: types, avg_rating: outfit.average_ratings, caption: outfit.caption, user: outfit.user.username, popularity: outfit.popularity, created_at: outfit.created_at})
    end
    render json: results
  end

  def create
    user = User.find(params[:user_id])
    fav = Favorite.create(favorite_params)
    user.user_favorites.create(favorite: fav)
  end

  private
  def favorite_params
    params.require(:favorite).permit(:fave_id, :fave_type)
  end

end
