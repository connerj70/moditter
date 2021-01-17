class User < ApplicationRecord

  validates :username, length: {maximum: 1000}, uniqueness: true
end
