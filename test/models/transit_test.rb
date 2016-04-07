require 'test_helper'
require "#{Rails.root}/app/models/transit.rb"

class TransitTest < ActiveSupport::TestCase

  test "can get travel type" do
    t = Transit.new
    assert_equal "", t.travel_type
  end

  test "can get min price" do
    t = Transit.new
    assert_equal nil, t.price_min
  end

  test "can get max price" do
    t = Transit.new
    assert_equal nil, t.price_max
  end

  test "can get eta" do
    t = Transit.new
    assert_equal nil, t.eta
  end

  test "can get special considerations" do
    t = Transit.new
    assert_equal "none", t.special_considerations
  end

  test "can get route map" do
    t = Transit.new
    assert_equal "", t.route_map
  end

  test "can get pickup point" do
    t = Transit.new
    assert_equal "", t.nearest_pickup_point
  end

  test "can get options" do
    t = Transit.new
    assert_equal nil, t.options[0]["ride_name"]
    assert_equal nil, t.options[0]["total_eta"]
    assert_equal nil, t.options[0]["pickup_eta"]
    assert_equal nil, t.options[0]["transit_time"]
    assert_equal nil, t.options[0]["price_max"]
  end

  test "can get start journey url" do
    t = Transit.new
    assert_equal "", t.start_journey_url
  end

end
