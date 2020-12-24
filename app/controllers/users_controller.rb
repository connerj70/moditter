class UsersController < ApplicationController
  def register
    @user = User.new
  end

  def register_twitter
    header = SimpleOAuth::Header.new('POST', 
                            'https://api.twitter.com/oauth/request_token', 
                            SimpleOAuth::Header.default_options,
                            {callback: ENV['TWITTER_CALLBACK_URL'], consumer_key: ENV['TWITTER_CONSUMER_KEY']}
                           )
    p header.to_s
    p header.url

    puts HTTParty.post(header.url, {headers: {'Authorization': header.to_s}})

  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show
    else
      p @user.errors
      render :register
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
