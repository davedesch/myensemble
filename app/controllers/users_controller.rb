class UsersController < ApplicationController


  def index
    render :index
  end


  def create
    prospective_user = User.new(user_params)
    # if params[:password] != nil
    # prospective_user.password = params[:password]
    if prospective_user.save
      current_user = prospective_user
      session[:user_id] = current_user.id
      redirect_to user_path(current_user.id)
    else
      @errors = prospective_user.errors
      p @errors
      render '/users/new'
    end
  # else
    # @moreerrors = "Sorry, one or more things were invalid. Please try again."
    # render 'users/new'
  # end
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
      results.push({outfit_id: outfit.id , title: outfit.title , image: outfit.image_url, types: types, avg_rating: outfit.average_ratings, caption: outfit.caption, user: outfit.user.username, popularity: outfit.popularity, created_at: outfit.created_at})
    end
    render json: results
  end

  def login #not logging in with instagram
    @user = User.find_by_username(params[:username])
      if @user && !params[:password].empty?
        if @user.password == params[:password]
          session[:user_id] = @user.id
          redirect_to user_path(@user)
          return
        else
          @errors = "Sorry, either your email or password didn't match"
        end
      else
        @errors = "Sorry, either your email or password didn't match"
      end

          render :index
  end


  def logout
    session.clear
    redirect_to "/"
  end



  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end


end