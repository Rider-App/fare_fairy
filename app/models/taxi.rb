class Taxi
  def initialize(origin, destination)

    @results = HTTParty.get()

  end

  def travel_type

    return "taxi"

  end

  def price_max
    # return price from taxi finder
  end

  def eta
    # return google maps driving eta
  end

  def options
    # array of hashes
    # "ride_name": "Taxi Cab Co",
    #               "price": ,
    #               "pickup_eta": ,
    #               "transit_time": ,
    #               "total_eta": ,
    #               "phone_number": "347-688-1992"
  end

end
