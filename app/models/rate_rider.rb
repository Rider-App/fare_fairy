class RateRider
  attr_reader :origin, :destination, :destination_address, :origin_address

  def initialize(origin, destination)

    address = Address.where("address = ?", origin).first
    if address
      @origin = "#{address.lat}, #{address.lng}"
      @start_lat = address.lat
      @start_lng = address.lng
      @origin_address = address.address
      @origin_city = address.city
      @origin_state = address.state
    else
      @origin_response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{origin}")
      @origin = location_coordinates(@origin_response)
      Address.create(address: origin, lat: start_lat, lng: start_lng, city: origin_city, state: origin_state)
    end

    address = Address.where("address = ?", destination).first
    if address
      @destination = "#{address.lat}, #{address.lng}"
      @end_lat = address.lat
      @end_lng = address.lng
      @destination_address = address.address
      @destination_city = address.city
      @destination_state = address.state
    else
      @destination_response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{destination}")
      @destination = location_coordinates(@destination_response)
      Address.create(address: destination, lat: end_lat, lng: end_lng, city: destination_city, state: destination_state)
    end

  end

  def formatted_addresses(response)
    response["results"].map {|r| r["formatted_address"]}
  end

  def origin_state
    if @origin_state
      @origin_state
    else
      state = @origin_response["results"][0]["address_components"].select {|a| a["types"].include? "administrative_area_level_1"}
      state[0]["short_name"]
    end
  end

  def origin_city
    if @origin_city
      @origin_city
    else
      city = @origin_response["results"][0]["address_components"].select {|a| a["types"].include? "locality"}
      if city.empty?
        city = @origin_response["results"][0]["address_components"].select {|a| a["types"].include? "sublocality"}
      end
      city[0]["short_name"]
    end
  end


  def destination_state
    if @destination_state
      @destination_state
    else
      state = @destination_response["results"][0]["address_components"].select {|a| a["types"].include? "administrative_area_level_1"}
      state[0]["short_name"]
    end
  end

  def destination_city
    if @destination_city
      @destination_city
    else
      city = @destination_response["results"][0]["address_components"].select {|a| a["types"].include? "locality"}
      if city.empty?
        city = @destination_response["results"][0]["address_components"].select {|a| a["types"].include? "sublocality"}
      end
      city[0]["short_name"]
    end
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
