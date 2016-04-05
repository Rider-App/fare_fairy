class Lyft
  # require 'httparty'

  attr_reader :cost, :auth_object, :token

  def initialize(start_lat, start_lng, end_lat, end_lng)

    # HOW DO WE GET THE LAT & LNG IN?
    # start_lat = 37.7772
    # start_lng = -122.4233
    # end_lat = 37.7972
    # end_lng = -122.4533

    @auth_response = HTTParty.post("https://api.lyft.com/oauth/token",
      {
        headers: {"Content-Type": "application/json"},
        body: {"grant_type": "client_credentials", "scope": "public"},
        basic_auth: { username: "#{ENV["LYFT_ID"]}", password: "#{ENV["LYFT_SECRET"]}"}
          }
            )

    @token = @auth_response["access_token"]

    @cost_response = HTTParty.get("https://api.lyft.com/v1/cost?start_lat=#{start_lat}&start_lng=#{start_lng}&end_lat=#{end_lat}&end_lng=#{end_lng}",
            {headers: {"Authorization": "bearer #{@token}"} } )

  end

  def travel_type
    "lyft"
  end

  def price_min
    min_array = @cost_response["cost_estimates"].map {|response| response["estimated_cost_cents_min"]}
    (min_array.min)/100.0
  end

  def price_max
    max_array = @cost_response["cost_estimates"].map {|response| response["estimated_cost_cents_max"]}
    (max_array.max)/100.0
  end

end
