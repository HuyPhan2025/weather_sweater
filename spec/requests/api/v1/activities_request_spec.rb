require "rails_helper"

RSpec.describe Api::V1::ActivitiesController do
  before do
    VCR.turn_off!
    WebMock.allow_net_connect!
  end
  
  after do
    VCR.turn_on!
    WebMock.disable_net_connect!
  end 
  
  it "#index" do
    get '/api/v1/activities?destination=Washington,DC'

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(parsed_data).to be_a(Hash)
    expect(parsed_data).to be_a(Hash)
    expect(parsed_data.keys).to eq([:data])
    expect(parsed_data[:data]).to be_a(Hash)
    expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
    expect(parsed_data[:data][:attributes]).to be_a(Hash)
    expect(parsed_data[:data][:attributes].keys).to eq([:destination, :forecast, :activities])
    expect(parsed_data[:data][:attributes][:destination]).to be_a(String)
    expect(parsed_data[:data][:attributes][:forecast]).to be_a(Hash)
    expect(parsed_data[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
    expect(parsed_data[:data][:attributes][:activities]).to be_an(Array)\
  end
end