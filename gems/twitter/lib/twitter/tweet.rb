require "simple_oauth"
require 'httparty'

module Twitter
  class Tweet
    def get_tweet(tweet_id: "", bearer_token: "")
      headers = { Authorization: "Bearer #{bearer_token}" }
      HTTParty.get("https://api.twitter.com/2/tweets/#{tweet_id}?expansions=attachments.media_keys&media.fields=url",
                   { headers: headers })
    end
  end
end
