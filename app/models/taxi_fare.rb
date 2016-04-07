class TaxiFare < Transit
  attr_reader :nearest_city_response, :fare_response, :companies_response, :response_string, :entity_handle, :convert_distance

  def initialize(start_lat=nil, start_lng=nil, end_lat=nil, end_lng=nil)

    @nearest_city_response = JSON.parse(HTTParty.get("https://api.taxifarefinder.com/entity?key=#{ENV["TFF_KEY"]}&location=#{start_lat},#{start_lng}"))
    @fare_response = JSON.parse(HTTParty.get("https://api.taxifarefinder.com/fare?key=#{ENV["TFF_KEY"]}&entity_handle=#{entity_handle}&origin=#{start_lat},#{start_lng}&destination=#{end_lat},#{end_lng}"))
    @companies_response = JSON.parse(HTTParty.get("https://api.taxifarefinder.com/businesses?key=#{ENV["TFF_KEY"]}&entity_handle=#{entity_handle}"))

  end

  def travel_type
    "Taxi"
  end

  def round_to
    (self * 10**x).round.to_f / 10**x
  end

  def convert_distance(meters)
    (meters * 0.000621371).round_to(2)
  end

  def entity_handle
    @nearest_city_response["handle"]
  end

  def total_fare
    @fare_response["total_fare"]
  end

  def extra_charges
    @fare_response["extra_charges"].reduce(0.0) {|sum, c| sum += c["charge"]}
  end

  








end
