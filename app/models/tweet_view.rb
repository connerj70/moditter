class TweetView < ApplicationRecord
  belongs_to :user

  def self.reset_counts
    TweetView.update_all count: 0
  end
end
