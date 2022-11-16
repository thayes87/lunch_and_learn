class FavoriteSerializer

  def self.add_favorite
    {
      "success": "Favorite added successfully"
    }
  end

  def self.invalid_key
    {
      "failure": "invalid key"
    }
  end

  def self.get_favorites(favs)
    {
      "data": favs.map do |fav|
        { "id": fav.id, 
          "type": "favorite",
          "attributes": {
            "recipe_title": fav.recipe_title,
            "recipe_link": fav.recipe_link,
            "country": fav.country,
            "created_at": fav.created_at
          }     
        }
      end
   } 
  end

  def self.no_favorites
    {
      "failure": "Unauthorized"
    }
  end
end