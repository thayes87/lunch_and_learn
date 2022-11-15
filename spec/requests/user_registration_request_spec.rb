require 'rails_helper'

RSpec.describe 'User request APIs' do
  context 'create a user - happy path' do
    it 'creates a user' do
      user_params = {
        name: Faker::Name.name,
        email: Faker::Internet.email
      }
      
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      created_user = User.last

      expect(response).to be_successful
      expect(created_user.name).to eq(user_params[:name])
      expect(created_user.email).to eq(user_params[:email])
    end
  end
end
