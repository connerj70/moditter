class CallbacksController < ApplicationController
    def twitter_callback
        logger.info('Starting twitter callback')

        header = SimpleOAuth::Header.new('POST', 'https://api.twitter.com/oauth/access_token', {}, {:consumer_secret => ENV['TWITTER_CONSUMER_SECRET'], :consumer_key => ENV['TWITTER_CONSUMER_KEY']})
        url = URI("https://api.twitter.com/oauth/access_token")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request["Authorization"] = header.to_s
        request.set_form_data(oauth_verifier: params[:oauth_verifier], oauth_token: params[:oauth_token])

        response = http.request(request)

        body = response.read_body

        return logger.error("Bad response code '#{response.code}' from Twitter /access_token: #{body}") unless response.code == "200"

        oauth_token, oauth_token_secret, user_id, screen_name = helpers.extract_access_token_params(body: body)

        #Check if we already have a user with this screen_name
        user = User.find_by(username: screen_name)
        if user.nil?
            logger.info("Creating a new user")
            # Because everything was successful we can create a user
            user = User.create!(username: screen_name)
            Oauth.create!(oauth_token: oauth_token, oauth_token_secret: oauth_token_secret, oauth_user_id: user_id, screen_name: screen_name, user_id: user.id)
        else
            logger.info("User already exists so updating Oauth")
            old_oauth = Oauth.find_by(user_id: user.id)
            old_oauth.update!(oauth_token: oauth_token, oauth_token_secret: oauth_token_secret)
        end

        # set the oauth_token on the users session
        session[:oauth_token] = oauth_token

        redirect_to user
        
    rescue StandardError => e
        logger.error("Error in twitter_callback: #{e}")
    end
end
