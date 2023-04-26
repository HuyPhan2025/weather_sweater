class RoadTripFacade
 
  #Main Method  
  def road_trip_info(origin, destination)
    city_cordinate = cities_lat_lng(origin, destination)

    direction = MapQuestService.get_directions(city_cordinate.first, city_cordinate.last)
    
    destination_weather = WeatherService.weather_datas(city_cordinate.last)

    weather_arrive = get_destination_weather(destination_weather, direction[:route][:time])

    road_trip_info = {
      start_city: origin,
      end_city: destination,
      travel_time: direction[:route][:formattedTime],
      weather_at_eta: {
        datetime: weather_arrive[:time],
        temperature: weather_arrive[:temp_f],
        condition: weather_arrive[:condition][:text]
      }
    }
    RoadTrip.new(road_trip_info)
  end

  #helper that return the lat and lng
  def cities_lat_lng(origin, destination)
    city_array = [origin, destination]

    lat_lng_array = city_array.filter_map do |city|
    get_lat_lng = MapQuestService.city_data(city)

    "#{get_lat_lng[:results].first[:locations].first[:latLng][:lat]},#{get_lat_lng[:results].first[:locations].first[:latLng][:lng]}"
    end
  end

  #helper that return time and weather
  def get_destination_weather(weather_info, travel_time)
    destination_time = Time.now + travel_time.seconds

    destination_day_forecast = weather_info[:forecast][:forecastday].find do |day|
      day[:date] == destination_time.to_s[0, 10]
    end

    destination_hour_forecast = destination_day_forecast[:hour].find do |hour|
      hour[:time] == destination_time.to_s[0, 14] + "00"
    end
  
  end
end