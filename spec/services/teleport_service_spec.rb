require "rails_helper"

RSpec.describe TeleportService do
  before do
    washington_salaries = File.read('spec/fixtures/washington_salaries.json')
    stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:washington-dc/salaries")
    .to_return(status: 200, body: washington_salaries, headers: {})
  end

  it "return a json object" do
    washington_info = TeleportService.washington_salaries

    expect(washington_info).to be_a(Hash)
    expect(washington_info.keys).to eq([:_links, :salaries])
  end
end