class GoogleTransit < Transit
  attr_reader :response

  def initialize(origin, destination)
    @response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&mode=transit&units=imperial&key=#{ENV["GOOGLE_MATRIX_KEY"]}")
  end

end
