class Lyft < Transit
  attr_reader :token

  def initialize(start_lat, start_lng, end_lat, end_lng)

    @auth_response = HTTParty.post("https://api.lyft.com/oauth/token",
      { headers: {"Content-Type": "application/json"},
        body: {"grant_type": "client_credentials", "scope": "public"},
        basic_auth: { username: "#{ENV["LYFT_ID"]}", password: "#{ENV["LYFT_SECRET"]}"}
      })

    @token = @auth_response["access_token"]

    @cost_response = HTTParty.get("https://api.lyft.com/v1/cost?start_lat=#{start_lat}&start_lng=#{start_lng}&end_lat=#{end_lat}&end_lng=#{end_lng}",
            {headers: {"Authorization": "bearer #{@token}"} } )

    @eta_response = HTTParty.get("https://api.lyft.com/v1/eta?lat=#{start_lat}&lng=#{start_lng}",
            {headers: {"Authorization": "bearer #{@token}"} } )

  end

  def travel_type
    "Lyft"
  end

  def convert_price(amount)
    (amount / 100.0) * primetime_multiplier
  end

  def convert_time(time_in_sec)
    (time_in_sec / 60.0).round
  end

  def price_min
    min_array = @cost_response["cost_estimates"].map {|response| response["estimated_cost_cents_min"]}
    convert_price(min_array.min)
  end

  def price_max
    max_array = @cost_response["cost_estimates"].map {|response| response["estimated_cost_cents_max"]}
    convert_price(max_array.max)
  end

  def eta
    etas = self.options.map {|e| e["total_eta"]}
    etas = etas.select {|a| a.class == Fixnum}
    etas.min
    # eta_hash = {}
    # @eta_response["eta_estimates"].map {|response| eta_hash["#{response["ride_type"]}"] = response["eta_seconds"]}
    # duration_hash = {}
    # @cost_response["cost_estimates"].map {|response| duration_hash["#{response["ride_type"]}"] = response["estimated_duration_seconds"]}
    # eta_hash.merge!(duration_hash){|key, eta, duration| eta + duration}
    # convert_time(eta_hash.values.min)
    # eta_array = @eta_response["eta_estimates"]
    # duration_array = @cost_response["cost_estimates"]
  end

  def primetime_multiplier
    primetime_percentage = @cost_response["cost_estimates"].first["primetime_percentage"].to_i
    primetime_percentage / 100.0 + 1
  end

  def special_considerations
    primetime_multiplier == 1 ? "none" : "prime time"
  end

  def options
    options = []
    @cost_response["cost_estimates"].each do |r|
      options_hash = {}
      options_hash["ride_name"] = r["display_name"]
      options_hash["price_min"] = convert_price(r["estimated_cost_cents_min"])
      options_hash["price_max"] = convert_price(r["estimated_cost_cents_max"])
      @eta_response["eta_estimates"].each do |e|
        if e["ride_type"] == r["ride_type"]
          e["eta_seconds"] ? options_hash["pickup_eta"] = convert_time(e["eta_seconds"]) : options_hash["pickup_eta"] =  "No cars available"
            break
        end
      end
      options_hash["transit_time"] = convert_time(r["estimated_duration_seconds"])
      options_hash["pickup_eta"].class == Fixnum ? options_hash["total_eta"] = options_hash["pickup_eta"] + options_hash["transit_time"] : options_hash["total_eta"] =  "No cars available"
      options << options_hash
    end
    options
  end

end
