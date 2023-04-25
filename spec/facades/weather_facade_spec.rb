require 'rails_helper'
require './app/facades/weather_facade'

RSpec.describe WeatherFacade do
  before do
    weather_info = File.read('spec/fixtures/washington_weather.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=#{ENV['WEATHER_API_KEY']}&q=38.89037,-77.03196&limit=5")
      .to_return(status: 200, body: weather_info, headers: {})

    city_info = File.read('spec/fixtures/washington_city.json')
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAP_QUEST_API_KEY"]}&location=Washington,DC")
        .to_return(status: 200, body: city_info, headers: {})

    washington_activity = File.read('spec/fixtures/washington_activity.json')
    stub_request(:get, "http://www.boredapi.com/api/activity/?type=%5B%5D")
        .to_return(status: 200, body: washington_activity, headers: {})

    activity = File.read('spec/fixtures/washington_activity.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=#{ENV['WEATHER_API_KEY']}&limit=5&q%5B%5D")
    .to_return(status: 200, body: activity, headers: {})
  end

  it "exists" do
    weather_facade = WeatherFacade.new
    
    expect(weather_facade).to be_a(WeatherFacade)
  end

  it "return the current weather" do
    weather_facade = WeatherFacade.new

    expect(weather_facade.city_weather_current("38.89037,-77.03196")).to be_a(Hash)
    expect(weather_facade.city_weather_current("38.89037,-77.03196").keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
  end

  it "return the hourly weather" do
    weather_facade = WeatherFacade.new

    expect(weather_facade.city_weather_daily("38.89037,-77.03196")).to be_an(Array)
    expect(weather_facade.city_weather_daily("38.89037,-77.03196").first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
  end

  it "return 5 day weather" do
    weather_facade = WeatherFacade.new
    expect(weather_facade.city_weather_hourly("38.89037,-77.03196")).to be_an(Array)
    expect(weather_facade.city_weather_hourly("38.89037,-77.03196").first.keys).to eq([:time, :temperature, :condition, :icon]) 
  end

  it "returns all weather info" do
    weather_facade = WeatherFacade.new

    expect(weather_facade.all_weather_info("Washington,DC")).to be_a(Forecast)
    expect(weather_facade.all_weather_info("Washington,DC").current_weather).to be_a(Hash)
    expect(weather_facade.all_weather_info("Washington,DC").daily_weather).to be_an(Array)
    expect(weather_facade.all_weather_info("Washington,DC").hourly_weather).to be_an(Array)
  end
end