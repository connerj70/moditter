# frozen_string_literal: true

module Twitter
  # Client to connect to twitter or local
  class Client
    def initialize(consumer_key: "", consumer_secret: "", oauth_token: "", oauth_token_secret: "", local: false)
      @oauth = if local
                 Twitter::MockOAuth.new
               else
                 Twitter::OAuth.new(consumer_secret: consumer_secret, consumer_key: consumer_key)
               end
      @timeline = if local
                    Twitter::MockTimeline.new
                  else
                    Twitter::Timeline.new(oauth_token: oauth_token, oauth_token_secret: oauth_token_secret)
                  end
      @tweet = if local
                 Twitter::MockTweet.new
               else
                 Twitter::Tweet.new
               end
    end

    def get_oauth_token
      @oauth.get_oauth_token
    end

    def generate_redirect_url(oauth_token:)
      @oauth.generate_redirect_url(oauth_token: oauth_token)
    end

    def get_access_token(oauth_verifier: "", oauth_token: "")
      @oauth.get_access_token(oauth_verifier: oauth_verifier, oauth_token: oauth_token)
    end

    def extract_access_token_params(body: "")
      @oauth.extract_access_token_params(body: body)
    end

    def fetch_timeline
      @timeline.fetch
    end

    def fetch_tweet(tweet_id: "", bearer_token: "")
      @tweet.get_tweet(tweet_id: tweet_id, bearer_token: bearer_token)
    end
  end
end
