class Uber
  attr_reader :prices, :times

  def initialize(origin_latitude=nil, origin_longitude=nil, destination_latitude=nil, destination_longitude=nil)
      header = {"Authorization" => "Token #{ENV["UBER_TOKEN"]}"}
      @prices = HTTParty.get("https://api.uber.com/v1/estimates/price?start_latitude=#{origin_latitude}&start_longitude=#{origin_longitude}&end_latitude=#{destination_latitude}&end_longitude=#{destination_longitude}", headers: header)
      @times = HTTParty.get("https://api.uber.com/v1/estimates/price?start_latitude=#{origin_latitude}&start_longitude=#{origin_longitude}", headers: header)
  end

  def travel_type
    "Uber"
  end

  def price_min
    min_array=[]
    @prices["prices"].each do |p|
      min_array << p["low_estimate"]
    end
    price_min = min_array.min
  end

  def price_max
    max_array=[]
    @prices["prices"].each do |p|
      max_array << p["high_estimate"]
    end
    price_max = max_array.max
  end

  def eta
    min_array=[]
    @times["times"].each do |t|
      min_array << t["estimate"]
    end
    eta = (min_array.min)/60

  end
end
