class FaresController < ApplicationController
  def show
    @rate_rider = RateRider.new(params[:origin], params[:destination])
    @uber = Uber.new(@rate_rider.start_lat, @rate_rider.start_lng, @rate_rider.end_lat, @rate_rider.end_lng)
  end
end
