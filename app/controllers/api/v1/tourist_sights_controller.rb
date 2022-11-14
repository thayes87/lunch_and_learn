class Api::V1::TouristSightsController < ApplicationController
  def index
    country = find_country
    lat, long = find_latlong(country)
    tourist_sights = TouristSightsService.get_tourist_sights(lat, long)
    render json: TouristSightsSerializer.results(tourist_sights)
  end
    
  private

  def find_latlong(country)
    CountryService.get_latlong(country)
  end

  def find_country
    if params[:format].nil?
      CountryService.get_random_country
    else
      params[:format]
    end
  end
end