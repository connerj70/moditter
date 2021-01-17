module Twitter

    def self.get_oauth_token

        Rails.logger.info("About to create header")

        header = SimpleOAuth::Header.new('POST', 'https://api.twitter.com/oauth/request_token', {}, {:consumer_secret => ENV['TWITTER_CONSUMER_SECRET'], :consumer_key => ENV['TWITTER_CONSUMER_KEY']})
        url = URI("https://api.twitter.com/oauth/request_token")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        
        request = Net::HTTP::Post.new(url)
        request["Authorization"] = header.to_s
        
        Rails.logger.info("About to post to /request_token")

        response = http.request(request)

        Rails.logger.info("About to read body from /request_token")

        body = response.read_body

        oauth_token = body.split("&")[0].split("=")[1]
    end

    def self.get_access_token(oauth_verifier: "", oauth_token: "")
        header = SimpleOAuth::Header.new('POST', 'https://api.twitter.com/oauth/access_token', {}, {:consumer_secret => ENV['TWITTER_CONSUMER_SECRET'], :consumer_key => ENV['TWITTER_CONSUMER_KEY']})
        url = URI("https://api.twitter.com/oauth/access_token")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request["Authorization"] = header.to_s
        request.set_form_data(oauth_verifier: oauth_verifier, oauth_token: oauth_token)

        response = http.request(request)

        body = response.read_body

        if response.code != "200"
            raise Error.new("Bad response code '#{response.code}' from Twitter /access_token: #{body}")
        end

        return body
    end

    def self.extract_access_token_params(body: "")
        params = body.split("&")
        oauth_token = params[0].split("=")[1]
        oauth_token_secret = params[1].split("=")[1]
        user_id = params[2].split("=")[1]
        screen_name = params[3].split("=")[1]

        return oauth_token, oauth_token_secret, user_id, screen_name
    end
end