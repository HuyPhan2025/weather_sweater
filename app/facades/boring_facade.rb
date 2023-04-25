class BoringFacade
  def weather_activity(location)
    lat_lng = WeatherFacade.new.lat_lng_info(location)
    current_forecast = modify_current_weather(lat_lng)
    hash = {
      destination: location,
      forecast: current_forecast,
      activities: all_activities(current_forecast[:temperature])
    }
    Activity.new(hash)
  end

  def modify_current_weather(lat_lng)
    current_weather = WeatherService.weather_datas(lat_lng)

    hash = current_weather[:current]
    data = {
      summary: hash[:condition][:text],
      temperature: hash[:temp_f]
    }
  end

  def all_activities(temp)
    types = ["relaxation", "busywork", "cooking", "recreational"]

    activities = {
      relaxation: BoringService.new.get_activity("relaxation"),
      cooking: BoringService.new.get_activity("cooking"),
      recreational: BoringService.new.get_activity("recreational"),
      busywork: BoringService.new.get_activity("busywork")
    }
    if temp >= 50 && temp < 60 
      [activities[:relaxation], activities[:busywork]]
    elsif temp >= 60 
      [activities[:recreational]]
    elsif temp < 50
      [activities[:cooking]]
    end

  end
end