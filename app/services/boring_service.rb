class BoringService
  def conn 
    Faraday.new("http://www.boredapi.com")
  end

  def get_activity(activity)
    response = conn.get("/api/activity/?type=#{activity}")
    JSON.parse(response.body, symbolize_names: true)
  end
end