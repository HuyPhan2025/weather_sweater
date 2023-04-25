class Api::V1::ActivitiesController < ApplicationController
  def index
    @activity = BoringFacade.new.weather_activity(params[:destination])
    render json: ActivitiesSerializer.new(@activity)
  end
end