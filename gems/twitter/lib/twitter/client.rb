# frozen_string_literal: true

module Twitter
  # Client to connect to twitter or local
  class Client
    def initialize(consumer_key:, consumer_secret:, local: false)
      @oauth = if local
                 Twitter::Mock::OAuth
               else
                 Twitter::OAuth.new(consumer_secret: consumer_secret, consumer_key: consumer_key)
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
  end
end
