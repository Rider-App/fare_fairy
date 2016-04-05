class RateRider
  attr_reader :response, :origin, :destination, :travel_options

  def initialize(origin, destination)
    @origin_response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{origin}")
    @origin = location_coordinates(@origin_response)
    @destination_response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{destination}")
    @destination = location_coordinates(@destination_response)

    @travel_options = get_transit_data
  end

  def get_transit_data
    options = []
  end

  def formatted_addresses(response)
    response["results"].map {|r| r["formatted_address"]}
  end

  def origin_address
    formatted_addresses(@origin_response).first
  end

  def destination_address
    formatted_addresses(@destination_response).first
  end

  def location_data(response)
    response["results"].first["geometry"]["location"]
  end

  def lat(response)
    location_data(response)["lat"]
  end

  def lng(response)
    location_data(response)["lng"]
  end

  def start_lat
    lat(@origin_response)
  end

  def start_lng
    lng(@origin_response)
  end

  def end_lat
    lat(@destination_response)
  end

  def end_lng
    lng(@destination_response)
  end

  def location_coordinates(response)
    "#{lat(response)}, #{lng(response)}"
  end


end
