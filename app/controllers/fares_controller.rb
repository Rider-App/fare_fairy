class FaresController < ApplicationController
  def show
    @origin = params[:origin]
    @destination = params[:destination]
    @rate_rider = RateRider.new(@origin, @destination)
    @uber = Uber.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng)
  end
end
