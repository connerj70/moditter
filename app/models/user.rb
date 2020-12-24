class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: {with: /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/} 
  validates :username, length: {maximum: 500}
  validates :password, length: {minimum: 10}
end
