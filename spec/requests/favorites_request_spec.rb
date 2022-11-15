require 'rails_helper'

RSpec.describe 'Add Favorite recipes' do
  context 'when the FE sends a Post request to add a recipe to a users favorite table' do
    it 'adds the recipe - happy path' do
      recipe_params = {
        api_key: "jgn983hy48thw9begh98h4539h4",
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      }
      
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      post '/api/v1/favorites', headers: headers, params: JSON.generate(recipe_params)

      recipe = Recipe.last
      recipe = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(new_user).to be_a Hash

      expect(recipe.keys).to eq([:success])
      expect(recipe[:success]).to eq("Favorite added successfully")
    end
  end