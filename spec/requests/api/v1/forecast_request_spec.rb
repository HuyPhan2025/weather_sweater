require 'rails_helper'

RSpec.describe 'Forecast Controller' do
  describe "#show" do
    before do
      weather_info = File.read('spec/fixtures/washington_weather.json')
      stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=#{ENV['WEATHER_API_KEY']}&latLng=38.89037,-77.03196&limit=5")
         .to_return(status: 200, body: weather_info, headers: {})

      city_info = File.read('spec/fixtures/washington_city.json')
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAP_QUEST_API_KEY"]}&location=Washington,DC")
        .to_return(status: 200, body: city_info, headers: {})
    end

    it "returns current, hourly, and daily forecast" do
      
      get '/api/v1/forecast?location=Washington,DC'
  
      expect(response).to be_successful
  
      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to be_a(Hash)
      expect(parsed_data.keys).to eq([:data])
      expect(parsed_data[:data][:attributes]).to be_a(Hash)
      expect(parsed_data[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])

      expect(parsed_data[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(parsed_data[:data][:attributes][:current_weather].keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])

      expect(parsed_data[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(parsed_data[:data][:attributes][:daily_weather][0].keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])

      expect(parsed_data[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(parsed_data[:data][:attributes][:hourly_weather][0].keys).to eq([:time, :temperature, :condition, :icon])
    end

    xit "return an error if city is not found" do
      get '/api/v1/forecast?location=abc'

      expect(response).to have_http_status(404)
      parsed_data = JSON.parse(response.body, symbolize_names: true)

    end
  end
end