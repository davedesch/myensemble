# ensemble
Dev Bootcamp Phase 3 Final Project.
TEAM: Dave Descheneaux, Saleh Rastani, Peter Fitzpatrick, Jessie Rushing

DB Schema
![db](/schema.png)


Layout-
navbar gets:
	- home
	- add/upload new ensemble
	- favorites dropdown
		- users
		- outfits
		- ratings
		- hashtags
	- logout


Routes-

get 'users/new' -new user sign up form

post '/login' -reidrect to main page

get '/users/:username' - show dashboard
	dashboard gets:
	- search box = start with hashtags
	- long scroll timeline (recently uploaded outfits from other users)
		- title
		- image
		- average rating (stars?)
		- articles list (clothing types descs)
		- caption
		- hanger to "favorite" this outfit
		- list of ratings?
		- empty stars to add your review, on click slides out a review box
	list can be sorted by date(created at), popularity(rating count * average stars), ratings(highest avg stars)

	- my recent outfits widget
	- trending widget

get '/ensembles'
	renders json of all ensembles

get '/users/username/ensembles/new'
	upload a new outfit form

post 'users/username/ensembles/'
	saves a new outfit for that user

get 'users/username/ensembles'
	render json list of all user's outfits

post 'users/username/ensembles/ensemble_id/reviews'
	saves a new review - no get route because form is hard coded as hidden div

get 'users/username/favorites/users'
	render json list of a users favorite users

get 'users/username/favorites/hashtags'
	render json list of a users favorite hashtags

get 'users/username/favorites/outfits'
	render json list of a users favorite outfits

get 'hashtags'
	json list of trending hashtags

get 'hashtags/:id'
	json list of ensembles with that hashtag (json format matches /ensembles )
