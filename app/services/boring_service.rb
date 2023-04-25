class BoringService
  def self.conn 
    Faraday.new("http://www.boredapi.com")
  end

  def self.washington_activities
    response = conn.get("/api/activity/")
    JSON.parse(response.body, symbolize_names: true)
  end
end