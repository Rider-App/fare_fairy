class Transit
  attr_reader :travel_type

  def initialize(travel_type="")
    @travel_type = travel_type
  end

  def price_min
    nil
  end

  def price_max
    nil
  end

  def eta
    "N/A"
  end

  def special_considerations
    "none"
  end

  def route_map
    ""
  end

  def nearest_pickup_point
    ""
  end

  def start_journey_url
    ""
  end

  def options
    [{"ride_name": "",
    "price_min": nil,
    "price_max": nil,
    "pickup_eta": nil,
    "transit_time": nil,
    "total_eta": nil}]
  end


end
