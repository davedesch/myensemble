CALLBACK_URL = "http://localhost:3000/oauth/callback"

Instagram.configure do |config|
	config.client_id = ENV['CLIENT_ID']
	config.client_secret = ENV['CLIENT_SECRET']
end