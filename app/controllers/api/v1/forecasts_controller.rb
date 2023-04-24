class Api::V1::ForecastsController < ApplicationController
  def show
    @forecast = WeatherFacade.new.all_weather_info
    render json: ForecastSerializer.new(@forecast)
  end
end