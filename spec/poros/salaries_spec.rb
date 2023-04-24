require 'rails_helper'

RSpec.describe Salaries do
  it "exists" do
    info = {
      destination: "",
      forecast: {},
      salaries: []
    }
    salaries = Salaries.new(info)
  
    expect(salaries).to be_a(Salaries)
  end
end