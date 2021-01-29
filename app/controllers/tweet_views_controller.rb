class TweetViewsController < ApplicationController
    def create
      puts "PARAMS #{params}"
      @user = User.find(params[:user])
      timelineJSON = Twitter.get_timeline(oauth_token: session[:oauth_token], oauth_token_secret: session[:oauth_token_secret])
      @timeline = JSON.parse(timelineJSON)

    rescue ActiveRecord::RecordNotFound => e
      flash[:error] = "User not found"
      redirect_to register_path
    rescue StandardError => e 
      flash[:error] = "There was an unexpected error"
      logger.error("There was an unexpected error in show: #{e}")
      render "users/show"
    end

    def index
      
    end
end
