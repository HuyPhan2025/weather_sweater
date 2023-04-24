class WeatherService
  def self.conn
    Faraday.new("http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = ENV["WEATHER_API_KEY"]
    end
  end

  def self.weather_datas
    response = conn.get("/v1/forecast.json?") do |faraday|
      faraday.params["latLng"] = "38.89037,-77.03196"
      faraday.params["limit"] = "5"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end