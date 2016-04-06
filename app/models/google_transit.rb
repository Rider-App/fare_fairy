class GoogleTransit < Transit
  attr_reader :response

  def initialize(origin, destination)
    response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&mode=transit&units=imperial&key=#{ENV["GOOGLE_MATRIX_KEY"]}")
    @directions = response["routes"][0]["legs"][0]["steps"]
  end

  def travel_type
    legs = @directions.select {|d| d["travel_mode"] == "TRANSIT"}
    legs.first["transit_details"]["line"]["vehicle"]["name"]
  end

end
