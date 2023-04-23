require "rails_helper"

RSpec.describe WeatherService do
  it "return a json object" do
    weather_info = WeatherService.weather_datas

    expect(weather_info).to be_a(Hash)
  end
end