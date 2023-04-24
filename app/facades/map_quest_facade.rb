class MapQuestFacade 
  def lat_lng_info
    lat = MapQuestService.city_data[:results][0][:locations][0][:latLng][:lat].to_s
    lng = MapQuestService.city_data[:results][0][:locations][0][:latLng][:lng].to_s

    lat_lng = lat + "," + lng
  end
end