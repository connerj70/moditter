require_relative '../../gems/twitter/lib/twitter'

class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def register_twitter
    logger.info('Starting register_twitter')
    local = ENV["RAILS_ENV"] == "production" ? false : true

    twitter_client = Twitter::Client.new(consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
                                         consumer_key: ENV['TWITTER_CONSUMER_KEY'], local: local)
    oauth_token = twitter_client.get_oauth_token
    puts "OAUTH TOKEN #{oauth_token}"
    redirect_url = twitter_client.generate_redirect_url(oauth_token: oauth_token)
    puts "REDIRECT URL: #{redirect_url}"
    logger.info('Redirecting to twitter for authorization')
    redirect_to redirect_url
  rescue StandardError => e
    logger.error("Error in register_twitter #{e}")
  end

  def show
    @user = User.find(params[:id])
    local = ENV["RAILS_ENV"] == "production" ? false : true
    twitter_client = Twitter::Client.new(oauth_token: session[:oauth_token], oauth_token_secret: session[:oauth_token_secret], local: local)
    @timeline = twitter_client.fetch_timeline

  rescue ActiveRecord::RecordNotFound => e
    flash[:error] = 'User not found'
    redirect_to register_path
  rescue Twitter::RateLimitExceeded => e
    flash.now[:error] = 'Rate limit exceeded. Please wait 15 minutes before requesting more tweets.'
  rescue StandardError => e
    flash[:error] = 'There was an unexpected error'
    logger.error("There was an unexpected error in show: #{e}")
  end

  def logout
    session.destroy
    redirect_to root_path
  end
end
