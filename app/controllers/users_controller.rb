 require_relative "../../gems/twitter/lib/twitter"

class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def register
    @user = User.new
  end

  def register_twitter
    logger.info("Starting register_twitter")

    oauth_token = Twitter.get_oauth_token

    redirect_url = "https://api.twitter.com/oauth/authorize?oauth_token=#{oauth_token}"

    logger.info("Redirecting to twitter for authorization")

    redirect_to redirect_url
  rescue StandardError => e
    logger.error("Error in register_twitter #{e}")
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def authenticate_user
    # TODO: We actually want to check here if their oauth_token is the same that matches the one we have saved in the DB,
    # If it's not we redirect them to the register page.
    unless session[:oauth_token].present?
      flash[:error] = "You must be logged in to acces this section"
      redirect_to register_path
    end
  end
end
