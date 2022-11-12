require 'rails_helper'

RSpec.describe CountryService do
  it "returns the common name of a random country" do
    country = CountryService.get_random_country

    expect(country).to be_a String
  end
end 