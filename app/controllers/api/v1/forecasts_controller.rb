class Api::V1::ForecastsController < ApplicationController
  # def index
  #   if params[:location] != ""
  #     @forecast = WeatherFacade.new.all_weather_info(params[:location])
  #     if @forecast.present?
  #       render json: ForecastSerializer.new(@forecast)
  #     else
  #       render json: ErrorSerializer.new.invalid_request, status: 400
  #     end
  #   end
  #   render json: ErrorSerializer.new.invalid_request, status: 400
  # end
  def index
    return render_error('Location is missing', 400) unless params[:location].present?

    @forecast = WeatherFacade.new.all_weather_info(params[:location])
    return render_error('Unable to get weather information', 400) unless @forecast.present?

    render json: @forecast, serializer: ForecastSerializer
  end

  private

  def render_error(message, status)
    render json: { error: message }, status: status
  end
end