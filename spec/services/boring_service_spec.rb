require "rails_helper"

RSpec.describe BoringService do
  before do
    washington_activity = File.read('spec/fixtures/washington_activity.json')
    stub_request(:get, "http://www.boredapi.com/api/activity/")
        .to_return(status: 200, body: washington_activity, headers: {})
  end
  it "return a json object" do
    washington_info = BoringService.washington_activities

    expect(washington_info).to be_a(Hash)
    expect(washington_info.keys).to eq([:activity, :type, :participants, :price, :link, :key, :accessibility])
  end
end