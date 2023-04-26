class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
 
  def initialize(info)
    @id = nil
    @start_city = info[:start_city]
    @end_city = info[:end_city]
    @travel_time = info[:travel_time]
    @weather_at_eta = info[:weather_at_eta]
  end
end