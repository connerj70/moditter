require "simple_oauth"
require "net/http"

module Twitter
    class <<self
        def get_timeline(oauth_token: "", oauth_token_secret: "")
            raise MissingOauthToken if oauth_token.strip.empty?
            raise MissingOauthTokenSecret if oauth_token_secret.strip.empty?

            header = SimpleOAuth::Header.new('GET', 'https://api.twitter.com/1.1/statuses/home_timeline.json', {}, 
                    {
                        :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'], 
                        :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
                        :token => oauth_token,
                        :token_secret => oauth_token_secret
                    }
                )
            url = URI("https://api.twitter.com/1.1/statuses/home_timeline.json")

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
            
            puts "BODY: #{body_parsed}"

            if body_parsed.include?("errors")
                raise RateLimitExceeded if ['errors'][0]['message'].include?("Rate limit exceeded")
            end

            return body_parsed
        end
    end
end