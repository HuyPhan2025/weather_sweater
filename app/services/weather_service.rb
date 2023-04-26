class WeatherService
  def self.conn
    Faraday.new("http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = ENV["WEATHER_API_KEY"]
    end
  end

  def self.weather_datas(lat_lng)
    response = conn.get("/v1/forecast.json") do |faraday|
      faraday.params["q"] = lat_lng
      faraday.params["days"] = 5
    end
    parse = JSON.parse(response.body, symbolize_names: true)
  end
end