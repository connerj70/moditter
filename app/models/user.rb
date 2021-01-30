class User < ApplicationRecord
  validates :username, length: {maximum: 1000}, uniqueness: true
  
  has_one :tweet_view
end
