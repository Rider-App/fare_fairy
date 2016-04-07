class FaresController < ApplicationController
  def show
    origin = params[:origin]
    destination = params[:destination]
    @rate_rider = RateRider.new(origin, destination)
    options = []

    uber = Uber.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng)
    if !uber.prices["fields"]
      options << uber
    else
      options << Transit.new("Uber")
    end

    lyft = Lyft.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng)
    if !lyft.cost_response["error_description"]
      options << lyft
    else
      options << Transit.new("Lyft")
    end

    google = GoogleTransit.new(origin, destination, "bus")
    if google.directions
      options << google
      options << GoogleTransit.new(origin, destination, "subway")
    end


    @options = options
  end
end
