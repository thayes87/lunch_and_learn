require 'rails_helper'

RSpec.describe 'tourist sights API request from FE', :vcr do
  #happy path
  context 'when given a valid country' do 
    it 'returns tourists sights for the given country within a 20000 meter radius of the capital', :vcr do
      get '/api/v1/tourist_sights?country=france'

      tourist_sights = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(tourist_sights).to be_a Hash

      tourist_sights[:data].each do |sight|
        expect(sight.keys). to eq([:id, :type, :attributes])
        expect(sight[:attributes].keys).to eq([:name, :address, :place_id])
        expect(sight[:id]).to eq(nil)
        expect(sight[:type]).to eq("tourist_sight")
        expect(sight[:attributes]).to be_a Hash
      end
    end
  end
  #sad path
  context 'when no country is given' do
    it 'returns recipes for a random country' do
      allow(CountryService).to receive(:get_random_country).and_return("Germany")
      get '/api/v1/tourist_sights'

      tourist_sights = JSON.parse(response.body, symbolize_names: true)

      expect(CountryService).to have_received(:get_random_country)
      expect(response).to be_successful
      expect(tourist_sights).to be_a Hash

      tourist_sights[:data].each do |sight|
        expect(sight.keys). to eq([:id, :type, :attributes])
        expect(sight[:attributes].keys).to eq([:name, :address, :place_id])
        expect(sight[:id]).to eq(nil)
        expect(sight[:type]).to eq("tourist_sight")
        expect(sight[:attributes]).to be_a Hash
      end
    end
  end
end