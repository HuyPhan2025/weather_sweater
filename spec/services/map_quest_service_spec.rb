require "rails_helper"

RSpec.describe MapQuestService do
  before do
    city_info = File.read('spec/fixtures/washington_city.json')
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=KEY&location=Washington,DC")
      .to_return(status: 200, body: city_info)
  end

  it "return a json object" do
    city = MapQuestService.city_data

    expect(city).to be_a(Hash)
    expect(city.keys).to eq([:info, :options, :results])
    expect(city[:results]).to be_an(Array)
    expect(city[:results][0].keys).to eq([:providedLocation, :locations])
    expect(city[:results][0][:locations][0]).to have_key(:latLng)
  end
end
