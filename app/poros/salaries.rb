class Salaries
  attr_reader :id, :destination, :forecast, :salaries

  def initialize(info)
    @id = nil
    @destination = info[:destination]
    @forecast = info[:forecast]
    @salaries = info[:salaries]
  end
end