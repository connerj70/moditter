require 'rails_helper'

RSpec.describe User, type: :model do
  context 'invalid' do
    it 'does not save with an invalid email address' do
      user = User.new
      user.email = 'bob.com'
      user.password = 'abc'
      saved = user.save
      expect(saved).to be_falsey
    end

    it 'does not save with a username that is too long' do
      user = User.new
      user.username = 'a' * 1000
      user.email = 'bob@gmail.com'
      user.password = 'abc'
      saved = user.save
      expect(saved).to be_falsey
    end

    it 'does not save when email is a duplicate' do
      user = User.new
      user.username = 'bob'
      user.password = 'abc'
      user.email = 'bob@example.com'
      user.save!

      user2 = User.new
      user2.username = 'bobby'
      user2.email = 'bob@example.com'
      user2.password = 'abc'
      saved = user2.save
      expect(saved).to be_falsey
    end
  end
end
