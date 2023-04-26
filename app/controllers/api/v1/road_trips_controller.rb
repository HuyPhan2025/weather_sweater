class Api::V1::RoadTripsController < ApplicationController

  def index
    road_trip = RoadTripFacade.new.road_trip_info(params[:origin], params[:destination])
    render json: RoadTripSerializer.new(road_trip)
  end

  private
  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination, :api_key)
  end
end