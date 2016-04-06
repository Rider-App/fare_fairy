class GoogleTransit < Transit
  attr_reader :response

  def initialize(origin, destination)
    @response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&mode=transit&units=imperial&key=#{ENV["GOOGLE_MATRIX_KEY"]}")
    @directions = @response["routes"][0]["legs"][0]["steps"]
  end

  def transit_modes
    @directions.select {|d| d["travel_mode"] == "TRANSIT"}
  end

  def travel_type
    transit_modes.first["transit_details"]["line"]["vehicle"]["name"]
  end

  def price_max
    fare = @response["routes"][0]["fare"]
    fare ? fare["value"] : nil
  end

  def eta
    (@response["routes"][0]["legs"][0]["duration"]["value"] / 60.0).round
  end

  def departure_time
    transit_modes.first["transit_details"]["departure_time"]["text"].to_time
  end

  def options
    options = []
    options_hash = {}
    options_hash["ride_name"] = transit_modes.first["transit_details"]["line"]["name"]
    options_hash["price_min"] = price_min
    options_hash["price_max"] = price_max
    options_hash["pickup_eta"] = (departure_time.to_time - Time.now) / 60
    options_hash["total_eta"] = eta
    options_hash["transit_time"] = eta

    options << options_hash

  end





end
