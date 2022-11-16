class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if !user.blank?
      fav = user.favorites.create(favorite_params)
      render json: FavoriteSerializer.add_favorite, status: 201
    else
      render json: FavoriteSerializer.invalid_key, status: 400
    end
  end

  def index
    user = User.find_by(api_key: params[:api_key])
    if !user.blank?
      favs = user.favorites
      render json: FavoriteSerializer.get_favorites(favs), status: 200
    else
      render json: FavoriteSerializer.no_favorites, status: 401
    end
  end

  def favorite_params
    params.require(:favorite).permit(:id, :api_key, :country, :recipe_link,  :recipe_title)
  end
end