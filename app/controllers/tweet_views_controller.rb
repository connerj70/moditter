class TweetViewsController < ApplicationController
    def create
      user = User.find(params[:user_id])
      tweet_view = user.tweet_view

      if tweet_view.count > 4
        render :error
        return
      end

      if tweet_view.nil?
        logger.info "A tweet view for this user does not already exist, creating one now"
        tweet_view = TweetView.create(user_id: user.id, count: 0)
      end

      tweet_view.increment!(:count)
      @tweet_content = params[:tweet_content]
      @tweet_user = params[:tweet_user]

    rescue ActiveRecord::RecordNotFound => e
      flash[:error] = "User not found"
      redirect_to register_path
    rescue StandardError => e 
      flash.now[:error] = "There was an unexpected error"
      logger.error("There was an unexpected error in show: #{e}")
    end
end
