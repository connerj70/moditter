require "simple_oauth"
require 'httparty'

module Twitter
    def self.get_tweet(tweet_id: "", bearer_token: "")
        headers = {Authorization: "Bearer #{bearer_token}"}
        HTTParty.get("https://api.twitter.com/2/tweets/#{tweet_id}", {headers: headers})
    end
end