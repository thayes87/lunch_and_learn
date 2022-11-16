require 'rails_helper'

RSpec.describe 'Favorite recipes' do
  context 'when the FE sends a Post request to add a recipe to a users favorite table' do
    it 'returns a successful response - happy path' do
      @user = create(:user)
      @user.create_api_key
     
      request_body = {
        api_key: "#{@user.api_key}",
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      }
      
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      post '/api/v1/favorites', headers: headers, params: JSON.generate(request_body)

      recipe = Favorite.last
      recipe = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(recipe).to be_a Hash
      expect(recipe.keys).to eq([:success])
      expect(recipe[:success]).to eq("Favorite added successfully")
    end

    it 'returns a unsuccessful response - sad path' do
      @user = create(:user)
      @user.create_api_key
      
      request_body = {
        api_key: "jgn983hy48thw9begh98h4539h4",
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      }
      
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      post '/api/v1/favorites', headers: headers, params: JSON.generate(request_body)

      recipe = Favorite.last
      recipe = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(recipe).to be_a Hash
      expect(recipe.keys).to eq([:failure])
      expect(recipe[:failure]).to eq("invalid key")
    end
  end

  context 'when the FE sends a GET request to return all favorite recipes for a user' do
    it 'returns all favorites for that user based on the provided api key' do
      user1 = create(:user)
      user2 = create(:user)
      user1.create_api_key
      user2.create_api_key

      recipe1 = create(:favorite, user_id: user1.id)
      recipe2 = create(:favorite, user_id: user1.id)
      recipe3 = create(:favorite, user_id: user1.id)
      recipe4 = create(:favorite, user_id: user2.id)
      
      request_body = {
        "api_key": "#{user1.api_key}"
        }
      
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      get '/api/v1/favorites', headers: headers, params: request_body

      favorites = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(favorites).to be_a Hash
      expect(favorites[:data].count).to eq(3)
      expect(favorites[:data]).to_not include(recipe4)

      favorites[:data].each do |favorite|
        expect(favorite.keys).to eq([:id, :type, :attributes])
        expect(favorite[:attributes].keys).to eq([:recipe_title, :recipe_link, :country, :created_at])
        expect(favorite[:id]).to be_a Integer
        expect(favorite[:type]).to eq("favorite")
        expect(favorite[:attributes]).to be_a Hash
      end
    end

    it 'returns an error code if the given api_key does not match a user' do
      user1 = create(:user)
      user2 = create(:user)
      user1.create_api_key
      user2.create_api_key

      recipe1 = create(:favorite, user_id: user1.id)
      recipe2 = create(:favorite, user_id: user1.id)
      recipe3 = create(:favorite, user_id: user1.id)
      recipe4 = create(:favorite, user_id: user2.id)

      request_body = {
        "api_key": "jgn983hy48thw9begh98h4539h4"
        }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      get '/api/v1/favorites', headers: headers, params: request_body

      favorites = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(favorites).to be_a Hash
    end
  end
end