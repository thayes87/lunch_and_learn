require 'rails_helper'

RSpec.describe CountryService do
  it "returns the common name of a random country" do
    country = CountryService.get_random_country

    expect(country).to be_a String
  end

  it "returns the lattitude and longitude of a given country" do
    country = "latvia"
    lat_long = CountryService.get_latlong(country)

    expect(lat_long).to be_an Array
  end
end