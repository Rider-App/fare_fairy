class Lyft
  # require 'httparty'

  attr_reader :cost, :auth_object, :token

  def initialize

    # HOW DO WE GET THE LAT & LNG IN?
    # start_lat = 37.7772
    # start_lng = -122.4233
    # end_lat = 37.7972
    # end_lng = -122.4533

    @auth_object = HTTParty.post("https://api.lyft.com/oauth/token",
      {
        headers: {"Content-Type": "application/json"},
        body: {"grant_type": "client_credentials", "scope": "public"},
        basic_auth: { username: "#{ENV["LYFT_ID"]}", password: "#{ENV["LYFT_SECRET"]}"}
          }
            )

    @token = @auth_object["access_token"]

    @cost = HTTParty.get("https://api.lyft.com/v1/cost?start_lat=37.7772&start_lng=-122.4233&end_lat=37.7972&end_lng=-122.4533",
            {headers: {"Authorization": "bearer #{@token}"} } )

  end


##########
# HTTPARTY: require 'httparty' => false
##########


# need to take out the hard coded auth code
# need to pass starting lat and starting lng into the method so they can come from somewhere

end
