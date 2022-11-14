class Api::V1::TouristSightsController < ApplicationController
  def index
    country = params[:format]
    lat, long = find_latlong(country)
    tourist_sights = TouristSightsService.get_tourist_sights(lat, long)
  end
    
  private

  def find_latlong(country)
    CountryService.get_latlong(country)
  end
end