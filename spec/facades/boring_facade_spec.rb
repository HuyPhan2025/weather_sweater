require "rails_helper"

RSpec.describe BoringFacade do
  before do
    VCR.turn_off!
    WebMock.allow_net_connect!
  end
  
  after do
    VCR.turn_on!
    WebMock.disable_net_connect!
  end 
  
  it "returns all weather activity" do
    activity = BoringFacade.new

    expect(activity.weather_activity("Washington,DC")).to be_a(Activity)
  end

  it "returns all activity be temperature" do
    activity = BoringFacade.new

    expect(activity.all_activities(55)).to be_an(Array)
    expect(activity.all_activities(55).first.keys).to eq([:activity, :type, :participants, :price, :link, :key, :accessibility])
  end

  it "return current temp and summary" do
    activity = BoringFacade.new

    expect(activity.modify_current_weather("38.89037,-77.03196")).to be_a(Hash)
    expect(activity.modify_current_weather("38.89037,-77.03196").keys).to eq([:summary, :temperature])
  end
end