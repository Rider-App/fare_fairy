class FaresController < ApplicationController
  def show
    origin = params[:origin]
    destination = params[:destination]
    @rate_rider = RateRider.new(origin, destination)
    ride_sharing = []
    transit = []

    options << Uber.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng)

    lyft = Lyft.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng)
    if !lyft.cost_response["error_description"]
      ride_sharing << lyft
    else
      ride_sharing << Transit.new("Lyft")
    end

    bus = GoogleTransit.new(origin, destination, "subway")
    if bus.directions
      transit << bus
      subway = GoogleTransit.new(origin, destination, "bus")
      transit << subway unless subway.ride_name == bus.ride_name && subway.travel_type == bus.travel_type
    end

    @ride_sharing = ride_sharing
    @transit = transit
  end
end
