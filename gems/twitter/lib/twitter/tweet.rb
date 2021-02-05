require "simple_oauth"
require "net/http"

module Twitter
    def self.get_tweet(tweet_id: "", oauth_token: "", oauth_token_secret: "")
        
        header = SimpleOAuth::Header.new('GET', "https://api.twitter.com/1.1/statuses/show.json?id=#{tweet_id}", {}, 
            {
                :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'], 
                :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
                :token => oauth_token,
                :token_secret => oauth_token_secret
            }
        )
        # v2 api https://api.twitter.com/2/tweets/:id
        # v1 api https://api.twitter.com/1.1/statuses/show.json?id=#{tweet_id}
        url = URI("https://api.twitter.com/1.1/statuses/show.json?id=#{tweet_id}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        
        request = Net::HTTP::Get.new(url)
        request["Authorization"] = header.to_s
        
        Twitter.logger.info("About to post to /statuses/show.json")

        response = http.request(request)

        Twitter.logger.info("About to read body from /statuses/show.json")

        body = response.read_body
        
        body_parsed = JSON.parse(body)
        
        if body_parsed.include?("errors")
            raise RateLimitExceeded if ['errors'][0]['message'].include?("Rate limit exceeded")
        end

        return body_parsed
    end
end