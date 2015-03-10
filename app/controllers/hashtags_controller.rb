class HashtagsController < ApplicationController

  def index
    # render json list of top trending hashtags (i.e. most popular hashtags)
    hashtags = Hashtag.select("hashtags.*, COUNT(outfit_tags.id) tag_count").joins(:outfit_tags).group("hashtags.id").order("tag_count DESC").limit(10)
    results = []
    hashtags.each do |hashtag|
      results.push({hashtag_id: hashtag.id, hashtag: hashtag.hashtag, count: hashtag.outfits.count})
    end
    render json: results
  end

  def show
    hashtag = Hashtag.find(params[:id])
    outfits = hashtag.outfits.order('created_at DESC').limit(50)
    results = []
    outfits.each do |outfit|
      types = []
      outfit.articles.each do |article|
        types.push(article.article_type.type_desc)
      end
      results.push({outfit_id: outfit.id , title: outfit.title , image: outfit.image_url, types: types, avg_rating: outfit.average_ratings, caption: outfit.caption, user: outfit.user.username, popularity: outfit.popularity, created_at: outfit.created_at})
    end
    render json: results
  end

  def search
    hashtag = Hashtag.find_by_hashtag(params[:hashtag])
    outfits = hashtag.outfits.order('created_at DESC').limit(50)
    results = []
    outfits.each do |outfit|
      types = []
      outfit.articles.each do |article|
        types.push(article.article_type.type_desc)
      end
      results.push({outfit_id: outfit.id , title: outfit.title , image: outfit.image_url, types: types, avg_rating: outfit.average_ratings, caption: outfit.caption, user: outfit.user.username, popularity: outfit.popularity, created_at: outfit.created_at})
    end
    render json: results
  end


end
