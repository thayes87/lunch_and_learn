class RecipeSerializer
  
  def self.results(recipes, country)

    {
      "data": recipes.map do |recipe|
        { "id": nil,
          "type": "recipe",
          "attributes": {
            "title" => recipe[:recipe][:label],
            "url" => recipe[:recipe][:url],
            "country" => country,
            "image" => recipe[:recipe][:image]
          }
        }
      end
    }
  end

  def self.no_result
    {
      "data": [
      ]
    }
  end
end
