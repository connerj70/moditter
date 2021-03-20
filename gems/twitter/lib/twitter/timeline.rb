require "simple_oauth"
require "net/http"

module Twitter
  class Timeline

    def initialize(oauth_token:, oauth_token_secret:)
      @oauth_token = oauth_token
      @oauth_token_secret = oauth_token_secret
    end

    def fetch
      raise MissingOauthToken if @oauth_token.strip.empty?
      raise MissingOauthTokenSecret if @oauth_token_secret.strip.empty?

      timeline_url = "https://api.twitter.com/1.1/statuses/home_timeline.json"

      header = SimpleOAuth::Header.new("GET", timeline_url, {},
                                       {
                                         consumer_secret: ENV["TWITTER_CONSUMER_SECRET"],
                                         consumer_key: ENV["TWITTER_CONSUMER_KEY"],
                                         token: @oauth_token,
                                         token_secret: @oauth_token_secret
                                       }
      )
      url = URI(timeline_url)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE


      request = Net::HTTP::Get.new(url)
      request["Authorization"] = header.to_s

      Twitter.logger.info("About to post to /home_timeline.json")

      response = http.request(request)

      Twitter.logger.info("About to read body from /home_timeline.json")

      body = response.read_body

      body_parsed = JSON.parse(body)

      if body_parsed&.include?("errors")
        raise RateLimitExceeded if ["errors"][0]["message"]&.include?("Rate limit exceeded")
      end

      puts body_parsed
      body_parsed
    end
  end
end
