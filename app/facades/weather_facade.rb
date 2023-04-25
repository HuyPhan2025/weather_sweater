class WeatherFacade

  def lat_lng_info(location)
    city = MapQuestService.city_data(location)
    lat = city[:results].last[:locations].first[:latLng][:lat].to_s
    lng = city[:results].last[:locations].first[:latLng][:lng].to_s

    lat + "," + lng 
  end

  def all_weather_info(location)
    lat_lng = lat_lng_info(location)

    all_weather_info = {
      current_weather: city_weather_current(lat_lng),
      daily_weather: city_weather_daily(lat_lng),
      hourly_weather: city_weather_hourly(lat_lng),
    }
    Forecast.new(all_weather_info)
  end

  def city_weather_current(lat_lng)
    current_weather = WeatherService.weather_datas(lat_lng)

    hash = current_weather[:current]
    data = {
      last_updated: hash[:last_updated],
      temperature: hash[:temp_f],
      feels_like: hash[:feelslike_f],
      humidity: hash[:humidity],
      uvi: hash[:uv],
      visibility: hash[:vis_miles],
      condition: hash[:condition][:text],
      icon: hash[:condition][:icon]
    }
  end

  def city_weather_daily(lat_lng)
    daily_weather = WeatherService.weather_datas(lat_lng)

    array = daily_weather[:forecast][:forecastday].map do |weather|
      weather
    end     

    info = array.map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def city_weather_hourly(lat_lng)
    hourly_weather = WeatherService.weather_datas(lat_lng)

    array = hourly_weather[:forecast][:forecastday].map do |weather|
      weather
    end     
    
    info = array.first[:hour].map do |day|
      day
    end
    
    hourly_weather = info.map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        condition: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end    
  end
end