class Activity
  attr_reader :destination, :forecast, :activities, :id

  def initialize(info)
    @id = nil
    @destination = info[:destination]
    @forecast = info[:forecast]
    @activities = info[:activities]
  end
end