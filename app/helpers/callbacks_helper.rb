module CallbacksHelper
    def extract_access_token_params(body: "")
        params = body.split("&")
        oauth_token = params[0].split("=")[1]
        oauth_token_secret = params[1].split("=")[1]
        user_id = params[2].split("=")[1]
        screen_name = params[3].split("=")[1]

        return oauth_token, oauth_token_secret, user_id, screen_name
    end
end
