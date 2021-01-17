class UsersController < ApplicationController
  def register
    @user = User.new
  end

  def register_twitter
    logger.info("Starting register_twitter")

    header = SimpleOAuth::Header.new('POST', 'https://api.twitter.com/oauth/request_token', {}, {:consumer_secret => ENV['TWITTER_CONSUMER_SECRET'], :consumer_key => ENV['TWITTER_CONSUMER_KEY']})
    url = URI("https://api.twitter.com/oauth/request_token")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = header.to_s

    logger.info("About to make request_token request")

    response = http.request(request)

    logger.info("Finished request_token request")

    body = response.read_body

    oauth_token = body.split("&")[0].split("=")[1]

    redirect_url = "https://api.twitter.com/oauth/authorize?oauth_token=#{oauth_token}"

    logger.info("Redirecting to twitter for authorization")

    redirect_to redirect_url
  rescue StandardError => e
    logger.error("Error in register_twitter #{e}")
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
