class UsersController < ApplicationController



  def index
    render :index
  end


  # def create
  #   prospective_user = User.new(user_params)
  #   # if params[:password] != nil
  #   prospective_user.password = params[:password]
  #   if prospective_user.save
  #     current_user = prospective_user
  #     session[:user_id] = current_user.id
  #     redirect_to user_path(current_user.id)
  #   else
  #     @errors = prospective_user.errors
  #     p @errors
  #     render '/users/new'
  #   end
  # # else
  #   # @moreerrors = "Sorry, one or more things were invalid. Please try again."
  #   # render 'users/new'
  # # end
  # end


  def show
    @user_id = session[:user_id]
    render :dashboard
  end

  def ensembles
    outfits = Outfit.order('created_at DESC').limit(50)
    results = get_outfit_details(outfits)
    # outfits.each do |outfit|
    #   articles = []
    #   outfit.articles.each do |article|
    #     articles.push({description: article.article_type.type_desc, brand: article.brand, brand_url: article.url, vintage: article.vintage, discontinued: article.discontinued})
    #   end
    #   ratings = []
    #   outfit.ratings.each do |rating|
    #     ratings.push({comment: rating.comment, stars: rating.stars, username: rating.user.username})
    #   end
    #   results.push({outfit_id: outfit.id , title: outfit.title , image: outfit.image_url, articles: articles, avg_rating: outfit.average_ratings, caption: outfit.caption, user: outfit.user.username, popularity: outfit.popularity, created_at: outfit.created_at, ratings: ratings})
    # end
    render json: results
  end

  # def login #not logging in with instagram
  #   @user = User.find_by_username(params[:username])
  #     if @user  # && !params[:password].empty?
  #       if @user.password_digest == params[:password]
  #         session[:user_id] = @user.id
  #         redirect_to user_path(@user)
  #         # return
  #       else
  #         @errors = "Sorry, either your email or password didn't match"
  #         render :index
  #       end
  #     # else
  #       # @errors = "Sorry, either your email or password didn't match"
  #     end

  # end


  # def logout
  #   session.clear
  #   redirect_to "/"
  # end
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      redirect_to '/register', :notice => "Sorry, your credentials were invalid. Please try again"
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_digest, :avatar)
  end


end
