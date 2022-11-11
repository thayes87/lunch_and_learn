require 'rails_helper'

RSpec.describe CountryService do
    it "returns country data" do
        countries = CountryService.get_countries

        expect(countries).to be_a Array
        expect(countries[0][:name]).to be_a Hash
        expect(countries[0][:name]).to have_key :common
        expect(countries[0][:name][:common]).to be_a String
    end
end 