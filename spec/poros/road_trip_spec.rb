require 'rails_helper'

RSpec.describe RoadTrip do
  it "exists" do
    info = {
      start_city: "Cincinnati, OH",
      end_city: "Chicago, IL",
      travel_time: "04:42:51",
      weather_at_eta: {:datetime=>"2023-04-26 10:00", :temperature=>42.4, :condition=>"Sunny"}
    }

    road_trip = RoadTrip.new(info)

    expect(road_trip).to be_a(RoadTrip)
  end
end
