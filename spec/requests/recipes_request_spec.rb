require 'rails_helper'

RSpec.describe 'recipe API request from FE', :vcr do
  context 'when given a valid country' do 
    it 'returns recipes for the given country' do
      get '/api/v1/recipes?country=canada'
  
      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(recipes).to be_a Hash
      
      recipes[:data].each do |recipe|
        expect(recipe.keys).to eq([:id, :type, :attributes])
        expect(recipe.keys.count).to eq(3)
        expect(recipe[:attributes].keys).to eq([:title, :url, :country, :image])
        expect(recipe)
        expect(recipe[:id]).to eq(nil)
        expect(recipe[:type]).to eq("recipe")
        expect(recipe[:attributes]).to be_a Hash
      end
    end
  end

  context 'when given an invalid country' do
    context 'and country is empty string' do
      it 'returns an empty array' do
        get '/api/v1/recipes?country= '

        recipes = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(recipes[:data]).to eq([])
      end 
    end
  end

  context 'and country is not a country' do
    it 'returns an empty array' do
      get '/api/v1/recipes?country=klansdnaoicneoin'

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(recipes[:data]).to eq([])
    end
  end
  

  context 'when no country is given' do
    it 'returns recipes for a random country' do
      allow(CountryService).to receive(:get_random_country)
      get '/api/v1/recipes'

      expect(CountryService).to have_received(:get_random_country)
    end
  end
end