class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user ||= Oauth.find_by(oauth_token: session[:oauth_token])&.user
  end

  def authenticate_user
    unless session[:oauth_token].present? && session[:oauth_token_secret].present?
      flash[:error] = 'You must be logged in to access this section'
      redirect_to register_path
    end
  end
end
