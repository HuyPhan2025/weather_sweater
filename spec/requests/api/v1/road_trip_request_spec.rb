require 'rails_helper'

RSpec.describe 'Road Trips Controller' do
  before do
    WebMock.allow_net_connect!
  end
  after do
    WebMock.disable_net_connect!
  end

  describe '#index' do
    it "returns a directions" do
      batman = User.create({ email: "bruce@example.com", password: "BillionAIR", api_key: SecureRandom.hex })
      user_params = { orgin: "Cincinnati, OH", destination: "Chicago, IL", api_key: batman.api_key }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/road_trip", headers: headers, params: user_params

      expect(response).to be_successful
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data).to be_a(Hash)
      expect(parsed_data.keys).to eq([:data])
      expect(parsed_data[:data]).to be_a(Hash)
      expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])

      expect(parsed_data[:data][:id]).to eq(nil)
      expect(parsed_data[:data][:type]).to eq("road_trip")
      expect(parsed_data[:data][:attributes]).to be_a(Hash)
      expect(parsed_data[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(parsed_data[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(parsed_data[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
    end
  end
end