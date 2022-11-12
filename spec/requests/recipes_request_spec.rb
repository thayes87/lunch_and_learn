require 'rails_helper'

RSpec.describe 'recipe API request from FE' do
  context 'when given a valid country' do 
    it 'returns recipes for the given country' do
      get api_v1_recipes_path("Canada")
  
      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(recipes).to be_a Hash
      
      recipes[:data].each do |recipe|
        expect(recipe[:id]).to eq(nil)
        expect(recipe[:type]).to eq("recipe")
        expect(recipe[:attributes]).to be_a Hash
        expect(recipe[:attributes].keys).to eq([:title, :url, :country, :image])
      end
    end
  end

  context 'when given an invalid country' do
    context 'and country is empty string' do
      it 'returns an empty array' do
        get api_v1_recipes_path(" ")

        recipes = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(recipes[:data]).to eq([])
      end 
    end
  end

    context 'and country is not a country' do
      it 'returns an empty array' do
        get api_v1_recipes_path("iyutsdjgxg")

        recipes = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(recipes[:data]).to eq([])
      end
    end
  

  context 'when no country is given' do
    it 'returns recipes for a random country' do
      allow(CountryService).to receive(:get_random_country)
      get api_v1_recipes_path()

      expect(CountryService).to have_received(:get_random_country)
    end
  end
end