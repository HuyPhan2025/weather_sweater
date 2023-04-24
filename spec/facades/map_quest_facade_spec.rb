require 'rails_helper'
require './app/facades/map_quest_facade'

RSpec.describe MapQuestFacade do
  before do
    city_info = File.read('spec/fixtures/washington_city.json')
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=KEY&location=Washington,DC")
      .to_return(status: 200, body: city_info)
  end

  it "exists" do
    map_quest_facade = MapQuestFacade.new

    expect(map_quest_facade).to be_a(MapQuestFacade)
  end

  it "return the lat and lng coordinates" do
    map_quest_facade = MapQuestFacade.new

    expect(map_quest_facade.lat_lng_info).to be_an(String)
  end
end