# frozen_string_literal: true

RSpec.describe Twitter do
  it "has a version number" do
    expect(Twitter::VERSION).not_to be nil
  end

  it "can get a users timeline" do
    body = Twitter.get_timeline()
    puts "BODY #{body}"
  end

  it 'can get a tweet' do
    puts Twitter.get_tweet(tweet_id: 1360690294723805186, bearer_token: ENV['TWITTER_BEARER_TOKEN'])
  end
end
