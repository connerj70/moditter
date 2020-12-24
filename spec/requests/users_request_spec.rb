require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe '#register' do
    it 'returns a valid 200 response' do
      get register_path
      expect(response.status).to eq(200)
    end

    it 'returns the correct template' do
      get register_path
      expect(response).to render_template(:register)
    end
  end

  describe '#register_twitter' do
    it 'creates a proper uri' do
      post register_twitter_path
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    context 'with a valid user' do
      it 'creates a user' do
        expect {
          post users_path, params: {user: {email: 'test@example.com', password: 'test123'}}
        }.to change { User.count } 
      end
    end

    context 'with an invalid user' do
      it 'returns an error'
    end
  end
end
