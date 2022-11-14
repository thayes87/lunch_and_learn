class LearningResourcesSerializer
  
  def self.results(country, video, images)

    {
      "data": { 
        "id": nil,
        "type": "learning_resource",
        "attributes": {
          "country" => country,
          "video" => {
            "title" => video[:items][0][:snippet][:title],
            "youtube_video_id" => video[:items][0][:id][:videoId]
          },
          "images" => images[:results].map do |image|
            {
              "alt_tag" => image[:alt_description],
              "url" => image[:urls][:raw]
            }
          end
        }
      }
    }
  end

  def self.no_result(country)
    {
      "data" => {
        "id" => nil,
        "type" => "learning_resource",
        "attributes" => {
          "country" => country,
          "video" => [],
          "images" => []
        }
      }
    }
  end
end
