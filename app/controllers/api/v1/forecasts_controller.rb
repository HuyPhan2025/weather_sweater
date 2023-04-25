class Api::V1::ForecastsController < ApplicationController
  def show
    @forecast = WeatherFacade.new.all_weather_info(params[:location])
    
    render json: ForecastSerializer.new(@forecast)
  end
end