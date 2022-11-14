class Api::V1::TouristSightsController < ApplicationController
  def index
    country = find_country
  end
    
  private

  def find_country
    if params[:format].nil?
      CountryService.get_random_country
    else
      params[:format]
    end
  end
end