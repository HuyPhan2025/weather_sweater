require "rails_helper"

RSpec.describe WeatherService do
  before do
    weather_info = File.read('spec/fixtures/washington_weather.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=#{ENV['WEATHER_API_KEY']}&latLng=38.89037,-77.03196&limit=5")
      .to_return(status: 200, body: weather_info, headers: {})

  end
  
  it "return a json object" do
    weather_info = WeatherService.weather_datas("38.89037,-77.03196")

    expect(weather_info).to be_a(Hash)
    expect(weather_info.keys).to eq([:location, :current, :forecast])
  end
end