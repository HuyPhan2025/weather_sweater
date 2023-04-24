class WeatherFacade

  def all_weather_info
    all_weather_info = {
      current_weather: city_weather_current,
      daily_weather: city_weather_daily,
      hourly_weather: city_weather_hourly,
    }
    Forecast.new(all_weather_info)
  end

  def city_weather_current
    current_weather = WeatherService.weather_datas

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

  def city_weather_daily
    daily_weather = WeatherService.weather_datas

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

  def city_weather_hourly
    hourly_weather = WeatherService.weather_datas

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

  def washington_weather_salaries
    washington_weather_salaries = {
      destination: MapQuestService.city_data[:results].first[:providedLocation][:location],
      forecast: city_weather_current,
      salaries: washington_salaries 
    }
    Salaries.new(washington_weather_salaries)
  end

  def washington_salaries 
    jobs = ['Data Analyst', 'Data Scientist', 'Mobile Developer', 'QA Engineer', 'Sofware Engineer', 'Systems Administrator', 'Web Developer']
    salaries_info = []
    salaries = TeleportService.washington_salaries
    jobs.each do |job|
      salaries[:salaries].map do |salary|
        
        if job == salary[:job][:title]
          salaries_info << {
            title: salary[:job][:title],
            min: salary[:salary_percentiles][:percentile_25],
            max: salary[:salary_percentiles][:percentile_75]
          }
        end
      end
    end
    salaries_info
  end
end