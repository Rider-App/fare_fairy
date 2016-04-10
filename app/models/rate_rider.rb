class RateRider
  attr_reader :origin, :destination, :destination_address, :origin_address

  def initialize(origin, destination)

    address = Address.where("address = ?", origin).first
    if address
      @origin = "#{address.lat}, #{address.lng}"
      @start_lat = address.lat
      @start_lng = address.lng
      @origin_address = address.address
    else
      @origin_response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{origin}")
      @origin = location_coordinates(@origin_response)
      Address.create(address: origin, lat: start_lat, lng: start_lng)
    end

    address = Address.where("address = ?", destination).first
    if address
      @destination = "#{address.lat}, #{address.lng}"
      @end_lat = address.lat
      @end_lng = address.lng
      @destination_address = address.address
    else
      @destination_response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{destination}")
      @destination = location_coordinates(@destination_response)
      Address.create(address: destination, lat: end_lat, lng: end_lng)
    end

  end

  def formatted_addresses(response)
    response["results"].map {|r| r["formatted_address"]}
  end

  def origin_address
    @origin_address || formatted_addresses(@origin_response).first
  end

  def destination_address
    @destination_address || formatted_addresses(@destination_response).first
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
    @start_lat || lat(@origin_response)
  end

  def start_lng
    @start_lng || lng(@origin_response)
  end

  def end_lat
    @end_lat || lat(@destination_response)
  end

  def end_lng
    @end_lng || lng(@destination_response)
  end

  def location_coordinates(response)
    "#{lat(response)}, #{lng(response)}"
  end


end
