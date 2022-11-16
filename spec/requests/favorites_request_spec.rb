require 'rails_helper'

RSpec.describe 'Add Favorite recipes' do
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
end