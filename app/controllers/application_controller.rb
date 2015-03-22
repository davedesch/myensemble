class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper :all

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def get_outfit_details(outfits)
    results = []
    outfits.each do |outfit|
      articles = []
      outfit.articles.each do |article|
        articles.push({description: article.article_type.type_desc, brand: article.brand, brand_url: article.url, vintage: article.vintage, discontinued: article.discontinued})
      end
      ratings = []
      outfit.ratings.each do |rating|
        ratings.push({comment: rating.comment, stars: rating.stars, username: rating.user.username})
      end
      results.push({outfit_id: outfit.id , title: outfit.title , image: outfit.image_url, articles: articles, avg_rating: outfit.average_ratings, caption: outfit.caption, user: outfit.user.username, popularity: outfit.popularity, created_at: outfit.created_at, ratings: ratings})
    end
    return results
  end

end
