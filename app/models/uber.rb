class Uber < Transit
  attr_reader :prices, :times

  def initialize(origin_latitude=nil, origin_longitude=nil, destination_latitude=nil, destination_longitude=nil)
      header = {"Authorization" => "Token #{ENV["UBER_TOKEN"]}"}
      @prices = HTTParty.get("https://api.uber.com/v1/estimates/price?start_latitude=#{origin_latitude}&start_longitude=#{origin_longitude}&end_latitude=#{destination_latitude}&end_longitude=#{destination_longitude}", headers: header)
      @times = HTTParty.get("https://api.uber.com/v1/estimates/time?start_latitude=#{origin_latitude}&start_longitude=#{origin_longitude}", headers: header)
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
    etas = self.options.map {|e| e[:total_eta]}
    etas = etas.select {|a| a.class == Fixnum}
    etas.min
  end

  def special_considerations
    surge_pricing = false
    @prices["prices"].each do |p|
      surge_pricing = true if p["surge_multiplier"] > 1
    end
    surge_pricing ? "surge pricing" : "none"
  end

  def options
    options_array = []
    @prices["prices"].each do |p|
      ride_name = p["display_name"]
      option_hash = { ride_name: p["display_name"],
                      price_min: p["low_estimate"],
                      price_max: p["high_estimate"]}

      @times["times"].each do |t|
        if t["display_name"] == ride_name
          option_hash[:pickup_eta] = (t["estimate"]/60)
          break
        else
          option_hash[:pickup_eta] = "No cars available"
        end
      end

      option_hash[:transit_time] = (p["duration"]/60)
      if option_hash[:pickup_eta] != "No cars available"
        option_hash[:total_eta] = option_hash[:pickup_eta].to_i + option_hash[:transit_time].to_i
      else
        option_hash[:total_eta] = "No cars available"
      end

      options_array << option_hash
    end
    options_array
  end
end
