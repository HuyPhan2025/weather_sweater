class Api::V1::SalariesController < ApplicationController
  def show
    @salaries = WeatherFacade.new.washington_weather_salaries
    render json: SalariesSerializer.new(@salaries)
  end
end