module Twitter
  class MockTweet
    def get_tweet(tweet_id: "", bearer_token: "")
      {"data"=>{"id"=>"1373357050529390593", "text"=>"RT @rileyflorence0: If someone were to provide a private place to live, food to eat, and studio space for a year so you could focus on your…"}}
    end
  end
end
