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
end