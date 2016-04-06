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

end
