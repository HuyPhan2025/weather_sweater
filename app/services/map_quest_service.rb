class MapQuestService

  def self.city_data(location)
    response = conn.get("geocoding/v1/address") do |faraday|
      faraday.params["location"] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new("https://www.mapquestapi.com/") do |faraday|
      faraday.params["key"] = ENV["MAP_QUEST_API_KEY"]
    end
  end
end