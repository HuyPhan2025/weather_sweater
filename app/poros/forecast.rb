class Forecast
  attr_reader :current_weather,
              :daily_weather, 
              :hourly_weather,
              :id

  def initialize(info)
     @id = nil
     @current_weather = info[:current_weather]
     @daily_weather = info[:daily_weather]
     @hourly_weather = info[:hourly_weather]
  end
end