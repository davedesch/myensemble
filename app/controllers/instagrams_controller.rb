class InstagramsController < ApplicationController

  CALLBACK_URL = "http://localhost:3000/instagram/oauth/callback"
  
  CLIENT = ENV['CLIENT_ID']

  #handles 'oauth/connect'
  def login
    redirect_to "https://api.instagram.com/oauth/authorize/?client_id=#{CLIENT}&redirect_uri=#{CALLBACK_URL}&response_type=code"    
  end

  #handles 'oauth/callback'
  def authorized
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    user = create_or_login(response)
    session[:user_id] = user.id
    redirect_to user_path(user.id)
  end

  def recent
    current_user = User.find(session[:user_id])
    client = Instagram.client(access_token: current_user.auth_token)
    user = client.user 
    @images = []
    client.user_recent_media.each do |media|
      p media.images
      @images.push(media.images.standard_resolution.url)
    end
    render file: '/app/views/users/itworked'
  end


private

  def create_or_login(response)
   user = User.where(username: response.user.username).first_or_create do |newuser|
        newuser.username = response.user.username
        newuser.avatar = response.user.profile_picture
        newuser.auth_token = response.access_token
        newuser.instagram_name = response.user.full_name
      end
    return user
  end


end
