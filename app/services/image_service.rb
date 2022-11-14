class ImageService
  
  def self.get_images(country)
    response = conn.get("/search/photos?query=#{country}")
    resp = parse(response)
  end

  private 

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com') do |faraday|
      faraday.params['client_id'] = ENV['unsplash_api_key']
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end