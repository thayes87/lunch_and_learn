class CountryService
  
  def self.get_random_country
    countries = get_countries
    countries.sample[:name][:common]
  end

  def self.get_latlong(country)
    response = conn.get("/v3.1/name/#{country}")
    resp = parse(response)
    resp.first[:latlng]
  end
  
  private 

  def self.get_countries
    response = conn.get('/v3.1/all')
    parse(response)
  end

  def self.conn
    Faraday.new(url: 'https://restcountries.com')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end