class TouristSightsService

  def self.get_tourist_sights(lat, long)
    response = conn.get("/v2/places?filter=circle:#{long},#{lat},20000")
    parse(response)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.geoapify.com') do |faraday|
      faraday.params['categories'] = 'tourism.sights'
      faraday.params['api_key'] = ENV['places_key']
    end
  end
  
  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end