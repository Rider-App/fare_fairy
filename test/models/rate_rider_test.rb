require 'test_helper'
require "#{Rails.root}/app/models/rate_rider.rb"

class RateRider
  def initialize
    @origin_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/rate_rider_test_origin.json"))
    @destination_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/rate_rider_test_destination.json"))

    @origin = location_coordinates(@origin_response)
    @destination = location_coordinates(@destination_response)
  end
end

class RateRiderTest < ActiveSupport::TestCase

  test "rate rider class exists" do
    assert RateRider
  end

  test "rate rider returns a coordinate" do
    rate_rider = RateRider.new
    assert_equal 36.0182578, rate_rider.start_lat
  end

  test "can return an origin address" do
    rate_rider = RateRider.new
    assert_equal "1214 Broad St, Durham, NC 27705, USA", rate_rider.origin_address
  end

  test "can return a destination address" do
    rate_rider = RateRider.new
    assert_equal "514 W Pettigrew St, Durham, NC 27701, USA", rate_rider.destination_address
  end

  test "can get origin city" do
    rate_rider = RateRider.new
    assert_equal "Durham", rate_rider.origin_city
  end

  test "can get origin state" do
    rate_rider = RateRider.new
    assert_equal "NC", rate_rider.origin_state
  end



end
