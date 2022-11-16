require 'rails_helper'

RSpec.describe TouristSightsService, :vcr do
  it "returns the tourist sights for the given country" do
    lat, long = [-41, 174]

    tourist_sites  = TouristSightsService.get_tourist_sights(lat, long)

    expect(tourist_sites).to be_a Hash
  end
end