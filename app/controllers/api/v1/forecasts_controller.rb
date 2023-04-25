class Api::V1::ForecastsController < ApplicationController
  def index
    if params[:location] != ""
      @forecast = WeatherFacade.new.all_weather_info(params[:location])
      if @forecast.present?
        render json: ForecastSerializer.new(@forecast)
      else
        render json: ErrorSerializer.new.invalid_request, status: 400
      end
    end
    render json: ErrorSerializer.new.invalid_request, status: 400
  end
end