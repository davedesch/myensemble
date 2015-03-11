Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"

  #this is the real one
  root 'users#index'

  #FIXED REGISTER ROUTES
  get '/register' => 'users#new'
  post '/users' => 'users#create'

  #use this one for heroku testing
  # root 'welcome#index'

  # Example of regular route:
  get 'instagram' => 'instagrams#index'
  get 'instagram/oauth/connect' => 'instagrams#login'
  get 'instagram/oauth/callback' => 'instagrams#authorized'
  get 'instagram/recent' => 'instagrams#recent'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end



  get '/ensembles' => 'users#ensembles'
  resources :users do
    # post 'login'
    # delete 'logout'
    resources :ensembles, as: :outfits, controller: :outfits do
      get 'new'
      post 'post'
      resources :ratings do
      end
    end
    resources :favorites do
      get 'users'
      get 'hashtags'
      get 'outfits'
      get 'articles'
    end
  end
  resources :hashtags
  get 'search' => 'hashtags#search'
  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end
  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable
  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
