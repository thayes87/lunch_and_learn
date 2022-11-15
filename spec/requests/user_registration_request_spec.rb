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

      new_user = User.last
      new_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(new_user).to be_a Hash

      expect(new_user[:data].keys).to eq([:type, :id, :attributes])
      expect(new_user[:data][:attributes].keys).to eq([:name, :email, :api_key])
      expect(new_user[:data][:id]).to be_a Integer
      expect(new_user[:data][:type]).to eq("user")
      expect(new_user[:data][:attributes]).to be_a Hash
    end
  end
end
