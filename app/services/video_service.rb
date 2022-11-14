class VideoService
  
  def self.get_video(country)
    response = conn.get("/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=#{country}")
    resp = parse(response)
  end

  private 

  def self.conn
    Faraday.new(url: 'https://youtube.googleapis.com') do |faraday|
      faraday.params['key'] = ENV['youtube_api_key']
      faraday.params['part'] = 'snippet'
      faraday.params['channelid'] = 'UCluQ5yInbeAkkeCndNnUhpw'
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end