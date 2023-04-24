class TeleportService
  def self.conn 
    Faraday.new("https://api.teleport.org/api/urban_areas/")
  end

  def self.washington_salaries
    response = conn.get("slug:washington-dc/salaries")
    JSON.parse(response.body, symbolize_names: true)
  end
end