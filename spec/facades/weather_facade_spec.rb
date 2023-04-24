require 'rails_helper'
require './app/facades/weather_facade'

RSpec.describe WeatherFacade do
  before do
    weather_info = File.read('spec/fixtures/washington_weather.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=#{ENV['WEATHER_API_KEY']}&latLng=38.89037,-77.03196&limit=5")
      .to_return(status: 200, body: weather_info, headers: {})

      washington_salaries = File.read('spec/fixtures/washington_salaries.json')
      stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:washington-dc/salaries")
      .to_return(status: 200, body: washington_salaries, headers: {})

      city_info = File.read('spec/fixtures/washington_city.json')
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=KEY&location=Washington,DC")
        .to_return(status: 200, body: city_info)
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

  it "returns all weather info" do
    weather_facade = WeatherFacade.new

    expect(weather_facade.all_weather_info).to be_a(Forecast)
    expect(weather_facade.all_weather_info.current_weather).to be_a(Hash)
    expect(weather_facade.all_weather_info.daily_weather).to be_an(Array)
    expect(weather_facade.all_weather_info.hourly_weather).to be_an(Array)
  end

  it "returns washington salaries" do
    weather_facade = WeatherFacade.new

    expect(weather_facade.washington_salaries).to be_a(Array)
    expect(weather_facade.washington_salaries.first.keys).to eq([:title, :min, :max])
  end

  it "returns current weather and salaries information" do
    weather_facade = WeatherFacade.new

    expect(weather_facade.washington_weather_salaries).to be_a(Salaries)
  end
end