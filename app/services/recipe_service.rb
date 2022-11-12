class RecipeService

  def self.get_recipes_by_country(country)
    response = conn.get("/api/recipes/v2?q=#{country}")
    resp = parse(response)

    resp[:hits][0...10]
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.edamam.com') do |faraday|
      faraday.params['type'] = 'public'
      faraday.params['app_id'] = ENV['edamam_id']
      faraday.params['app_key'] = ENV['edamam_key']
    end
  end
  
  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end