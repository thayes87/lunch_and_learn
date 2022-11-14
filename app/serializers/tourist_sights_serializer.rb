class TouristSightsSerializer
  
  def self.results(tourist_sights)

    {
      "data": tourist_sights[:features].map do |sight|
        { "id": nil,
          "type": "tourist_sight",
          "attributes": {
            "name" => sight[:properties][:name],
            "address" => sight[:properties][:formatted],
            "place_id" => sight[:properties][:place_id]
          }
        }
      end
    }
  end
end