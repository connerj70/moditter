require_relative '../../gems/twitter/lib/twitter'

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
      tweet = Twitter.get_tweet(tweet_id: params[:tweet_id], bearer_token: ENV['TWITTER_BEARER_TOKEN'])
      @tweet_content = tweet['data']['text']
      @tweet_user = params[:tweet_user]

      puts tweet
      if tweet['includes']
        if tweet['includes']['media'].any?
          @tweet_image_url = tweet['includes']['media'][0]['url']
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      flash[:error] = "User not found"
      redirect_to register_path
    rescue StandardError => e 
      flash.now[:error] = "There was an unexpected error"
      logger.error("There was an unexpected error in show: #{e}")
    end
end
