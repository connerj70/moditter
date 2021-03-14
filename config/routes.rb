Rails.application.routes.draw do
  get '/about', to: 'about#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#register'
  get '/register', to: 'users#register'
  get '/register_twitter', to: 'users#register_twitter'
  resources :users, except: [:new] 

  # Callbacks
  get '/twitter_callback', to: 'callbacks#twitter_callback'

  # TweetViews
  post '/tweet_views', to: 'tweet_views#create'
  get '/tweet_views', to: 'tweet_views#index'
end
