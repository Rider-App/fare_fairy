class FaresController < ApplicationController
  def show
    origin = params[:origin]
    destination = params[:destination]
    @rate_rider = RateRider.new(origin, destination)
    ride_sharing = []
    transit = []
    taxis = []

    ride_sharing << Uber.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng)

    ride_sharing << Lyft.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng)

    bus = GoogleTransit.new(origin, destination, "subway")
    if bus.valid?
      transit << bus
      subway = GoogleTransit.new(origin, destination, "bus")
      transit << subway unless subway.ride_name == bus.ride_name && subway.travel_type == bus.travel_type
    end

    taxis << TaxiFare.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng, @rate_rider.origin_city, @rate_rider.origin_state )

    @ride_sharing = ride_sharing
    @transit = transit
    @taxis = taxis
  end
end
