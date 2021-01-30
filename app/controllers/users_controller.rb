require_relative "../../gems/twitter/lib/twitter"

class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def register_twitter
    logger.info("Starting register_twitter")
    oauth_token = Twitter.get_oauth_token
    redirect_url = Twitter.generate_redirect_url(oauth_token: oauth_token)
    logger.info("Redirecting to twitter for authorization")
    redirect_to redirect_url
  rescue StandardError => e
    logger.error("Error in register_twitter #{e}")
  end

  def show
    @user = User.find(params[:id])
    @timeline = Twitter.get_timeline(oauth_token: session[:oauth_token], oauth_token_secret: session[:oauth_token_secret])

  rescue ActiveRecord::RecordNotFound => e
    flash[:error] = "User not found"
    redirect_to register_path
  rescue Twitter::RateLimitExceeded => e
    flash.now[:error] = "Rate limit exceeded. Please wait 15 minutes before requesting more tweets."
  rescue StandardError => e 
    flash[:error] = "There was an unexpected error"
    logger.error("There was an unexpected error in show: #{e}")
  end

  private

  def authenticate_user
    unless session[:oauth_token].present? && session[:oauth_token_secret].present?
      flash[:error] = "You must be logged in to access this section"
      redirect_to register_path
    end
  end
end
