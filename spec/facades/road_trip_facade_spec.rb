require 'rails_helper'

RSpec.describe RoadTripFacade do
  before do
    WebMock.allow_net_connect!
  end
  after do
    WebMock.disable_net_connect!
  end

  it 'exists' do
    road_trip = RoadTripFacade.new

    expect(road_trip).to be_a(RoadTripFacade)
  end

  it "get the cities lat and lng" do
    road_trip = RoadTripFacade.new

    expect(road_trip.cities_lat_lng("Cincinnati, OH", "Chicago, IL")).to eq(["39.10713,-84.50413", "41.88425,-87.63245"])
  end

  it "return the weather forecast for the arrival destination" do
    road_trip = RoadTripFacade.new
    weather_info = WeatherService.weather_datas("41.88425,-87.63245")
    travel_time = 16963
  
    result = road_trip.get_destination_weather(weather_info, travel_time)
    
    expect(result).to be_a(Hash)
  end

  it "return road trip info" do
    road_trip = RoadTripFacade.new

    expect(road_trip.road_trip_info("Cincinnati, OH", "Chicago, IL").start_city).to eq("Cincinnati, OH")
    expect(road_trip.road_trip_info("Cincinnati, OH", "Chicago, IL").end_city).to eq("Chicago, IL")
    expect(road_trip.road_trip_info("Cincinnati, OH", "Chicago, IL").travel_time).to be_a(String)
    expect(road_trip.road_trip_info("Cincinnati, OH", "Chicago, IL").weather_at_eta).to be_a(Hash)
    expect(road_trip.road_trip_info("Cincinnati, OH", "Chicago, IL").weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
  end
end