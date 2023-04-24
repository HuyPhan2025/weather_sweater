class ForecastSerializer
  include JSONAPI::Serializer
  attributes :current_weather, :daily_weather, :hourly_weather, :daily_weather
end