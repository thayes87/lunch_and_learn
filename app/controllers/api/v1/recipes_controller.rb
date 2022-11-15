class Api::V1::RecipesController < ApplicationController
  def index
    country = find_country
    recipes = RecipeService.get_recipes_by_country(country)
    
    if recipes.present?
      render json: RecipeSerializer.results(recipes, country)
    else
      render json: RecipeSerializer.no_result
    end
  end

  private

  def find_country
    if params[:country].nil?
      CountryService.get_random_country
    else
      params[:country]
    end
  end
end