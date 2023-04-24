require 'rails_helper'

RSpec.describe 'Salaries Controller' do
  describe "#show" do
    before do
      city_info = File.read('spec/fixtures/washington_city.json')
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=KEY&location=Washington,DC")
        .to_return(status: 200, body: city_info)

        weather_info = File.read('spec/fixtures/washington_weather.json')
        stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=#{ENV['WEATHER_API_KEY']}&latLng=38.89037,-77.03196&limit=5")
          .to_return(status: 200, body: weather_info, headers: {})

          washington_salaries = File.read('spec/fixtures/washington_salaries.json')
          stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:washington-dc/salaries")
          .to_return(status: 200, body: washington_salaries, headers: {})
    end

    it "returns the current weather and salaries" do
      get '/api/v1/salaries?destination=Washington,DC'

      expect(response).to be_successful

      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to be_a(Hash)
      expect(parsed_data.keys).to eq([:data])
      expect(parsed_data[:data]).to be_a(Hash)
      expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
      expect(parsed_data[:data][:attributes]).to be_a(Hash)
      expect(parsed_data[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
      expect(parsed_data[:data][:attributes][:destination]).to be_a(String)
      expect(parsed_data[:data][:attributes][:forecast]).to be_a(Hash)
      expect(parsed_data[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(parsed_data[:data][:attributes][:salaries]).to be_an(Array)
      expect(parsed_data[:data][:attributes][:salaries].first.keys).to eq([:title, :min, :max])
    end
  end
end