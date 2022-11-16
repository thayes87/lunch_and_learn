require 'rails_helper'

RSpec.describe RecipeService, :vcr do
  it "returns the recipes for the given country" do
    country = "Thailand"
    recipes = RecipeService.get_recipes_by_country(country)

    expect(recipes).to be_a Array
    expect(recipes.size).to eq(10)
  end
end