require 'rails_helper'

RSpec.describe 'learning resources API request from FE' do
  context 'when given a valid country' do 
    it 'returns a learning resources for the given country' do
      get api_v1_learning_resources_path("Canada")
  
      learning_resources = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(learning_resources).to be_a Hash

      expect(learning_resources[:data].keys).to eq([:id, :type, :attributes])
      expect(learning_resources[:data][:attributes].keys).to eq([:country, :video, :images])
      expect(learning_resources[:data][:id]).to eq(nil)
      expect(learning_resources[:data][:type]).to eq("learning_resource")
      expect(learning_resources[:data][:attributes]).to be_a Hash
      expect(learning_resources[:data][:attributes][:video]).to be_a Hash
      expect(learning_resources[:data][:attributes][:video].keys).to eq([:title, :youtube_video_id])
      expect(learning_resources[:data][:attributes][:images]).to be_a Array
      learning_resources[:data][:attributes][:images].each do |image|
        expect(image.keys).to eq([:alt_tag, :url])
      end
    end
  end
end