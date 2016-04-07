class TaxiFare < Transit
  attr_reader :nearest_city_response, :fare_response, :companies_response, :response_string, :entity_handle, :convert_distance, :round_to

  def initialize(start_lat=nil, start_lng=nil, end_lat=nil, end_lng=nil)

    @nearest_city_response = JSON.parse(HTTParty.get("https://api.taxifarefinder.com/entity?key=#{ENV["TFF_KEY"]}&location=#{start_lat},#{start_lng}"))
    @fare_response = JSON.parse(HTTParty.get("https://api.taxifarefinder.com/fare?key=#{ENV["TFF_KEY"]}&entity_handle=#{entity_handle}&origin=#{start_lat},#{start_lng}&destination=#{end_lat},#{end_lng}"))
    @companies_response = JSON.parse(HTTParty.get("https://api.taxifarefinder.com/businesses?key=#{ENV["TFF_KEY"]}&entity_handle=#{entity_handle}"))

  end

  def travel_type
    "Taxi"
  end

  def convert_distance(meters)
    (meters * 0.000621371).round(2)
  end

  def entity_handle
    @nearest_city_response["handle"]
  end

  def tip_amount
    real_tip = ((@fare_response["total_fare"] - @fare_response["tip_amount"]) * 0.15).round
    if real_tip < 5
      5
    else
      real_tip
    end
  end

  def total_fare
    polite_fare = @fare_response["total_fare"] - @fare_response["tip_amount"]
    polite_fare += tip_amount
    polite_fare.round

    #take total fare into account when giving a tip
    #take out their tip amount and replace it with reasonable tip method
  end

  def price_min
    @fare_response["total_fare"] - @fare_response["tip_amount"]
  end

  def price_max
    @fare_response["total_fare"]
  end

  def eta
    "No information available"
  end

  # returns the sum of all extra charges
  def extra_charges
    @fare_response["extra_charges"].reduce(0.0) {|sum, c| sum += c["charge"]}
  end

  # returns the hash of extra_charges, namely the "charge" and "description" fields
  def special_considerations
    @fare_response["extra_charges"]
  end

  def options
    opt_array = []
    opt_hash = {}
    opt_hash["ride_name"] = "Local taxi"
    opt_hash["price_min"] = @fare_response["total_fare"] - @fare_response["tip_amount"]
    opt_hash["price_max"] = @fare_response["total_fare"]
    opt_hash["eta_estimates"] = "N/A"
    opt_hash["transit_time"] = "N/A"
    opt_hash["pickup_eta"] = "N/A"
    opt_array << opt_hash
    opt_array
  end

  def call_one_cab
    cab_array = []
    cab_array << (@companies_response["businesses"][0]["name"])
    cab_array << (@companies_response["businesses"][0]["phone"])
    cab_array
  end

  def call_all_cabs
    cab_array = []
    (@companies_response["businesses"]).each do |i|
      temp_array = []
      temp_array << [i][0]["name"]
      temp_array << [i][0]["phone"]
      cab_array << temp_array
    end
    cab_array
  end

end
