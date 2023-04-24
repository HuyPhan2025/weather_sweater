require 'rails_helper'

RSpec.describe Forecast do
  it "exists" do
    info = {
      current_weather: {},
      daily_weather: [],
      hourly_weather: []
    }
    forecast = Forecast.new(info)

    expect(forecast).to be_a(Forecast)
  end
end