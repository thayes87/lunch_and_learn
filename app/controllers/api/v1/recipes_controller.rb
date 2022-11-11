class Api::V1::RecipesController < ApplicationController
  def index
    if params.nil?
      render json: RecipeSerializer.new(country)

    else
      
    end
  end
end