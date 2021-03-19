module Twitter
  class MockOAuth
    def get_oauth_token
      "U6W6owAAAAABKxmjAAABeEhFeAQ"
    end

    def get_access_token(oauth_verifier:, oauth_token:)
      "oauth_token=842116716754681856-UoYxjiSvNyes0gTVoWvxtzhO2y7oWT1&oauth_token_secret=DWc3qYt196b1GgNzNbbHwgsja6Gt7KKkoBhv091c1hrTz&user_id=842116716754681856&screen_name=connerjensen780"
    end

    def extract_access_token_params(body: "")
      %w[842116716754681856-UoYxjiSvNyes0gTVoWvxtzhO2y7oWT1 DWc3qYt196b1GgNzNbbHwgsja6Gt7KKkoBhv091c1hrTz 842116716754681856 connerjensen780]
    end

    def generate_redirect_url(oauth_token:)
      "http://localhost:3000/twitter_callback?oauth_verified=a&oauth_token=b"
    end
  end
end
