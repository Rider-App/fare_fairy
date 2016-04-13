class GoogleTransit < Transit

  def initialize(origin, destination, mode=nil)
    @origin = origin
    @destination = destination
    @response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&mode=transit&transit_mode=#{mode}&units=imperial&key=#{ENV["GOOGLE_MATRIX_KEY"]}")
  end

  def valid?
    @response["status"] == "OK"
  end

  def start_journey_url
    origin = @origin.gsub(" ", "+")
    destination = @destination.gsub(" ", "+")
    "http://maps.google.com?saddr=#{origin}&daddr=#{destination}&directionsmode=transit"
  end

  def directions
    @response["routes"][0]["legs"][0]["steps"]
  end

  def transit_modes
    directions.select {|d| d["travel_mode"] == "TRANSIT"}
  end

  def travel_type
    modes = transit_modes.map { |t| t["transit_details"]["line"]["vehicle"]["name"] }
    modes.uniq * " + "
  end

  def price_max
    fare = @response["routes"][0]["fare"]
    fare ? fare["value"] : nil
  end

  def eta
    (@response["routes"][0]["legs"][0]["duration"]["value"] / 60.0).round
  end

  def departure_time(index = 0)
    time = transit_modes[index]["transit_details"]["departure_time"]["value"]
    Time.at(time).utc
  end

  def ride_name
    options[0]["ride_name"]
  end

  def options
    options = []
    transit_modes.each_with_index do |t, i|
      options_hash = {}
      options_hash["ride_name"] = t["transit_details"]["line"]["name"]
      options_hash["short_name"] = t["transit_details"]["line"]["short_name"]
      options_hash["price_min"] = price_min
      options_hash["price_max"] = price_max
      options_hash["pickup_eta"] = ((departure_time(i) - Time.now.utc) / 60).round
      options_hash["transit_time"] = (t["duration"]["value"] / 60.0).round
      options_hash["total_eta"] = eta

      options << options_hash

    end
    options
  end





end
