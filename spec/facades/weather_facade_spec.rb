require 'rails_helper'
require './app/facades/weather_facade'

RSpec.describe WeatherFacade do
  before do
    weather_info = File.read('spec/fixtures/washington_weather.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=2d9220dbffaf416fa1725207232204&latLng=38.89037,-77.03196&limit=5")
      .to_return(status: 200, body: weather_info, headers: {})
  end

  it "exists" do
    weather_facade = WeatherFacade.new
    
    expect(weather_facade).to be_a(WeatherFacade)
  end

  it "return the current weather" do
    weather_facade = WeatherFacade.new

    expect(weather_facade.city_weather_current).to be_a(Hash)
    expect(weather_facade.city_weather_current.keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
  end

  it "return the hourly weather" do
    weather_facade = WeatherFacade.new

    expect(weather_facade.city_weather_daily).to be_an(Array)
    expect(weather_facade.city_weather_daily.first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
  end

  it "return 5 day weather" do
    weather_facade = WeatherFacade.new
    expect(weather_facade.city_weather_hourly).to be_an(Array)
    expect(weather_facade.city_weather_hourly.first.keys).to eq([:time, :temperature, :condition, :icon]) 
  end
end