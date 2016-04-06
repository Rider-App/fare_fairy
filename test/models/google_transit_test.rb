require 'test_helper'
require "#{Rails.root}/app/models/google_transit.rb"

class GoogleTransit
  def initialize
    @response = JSON.parse(File.read("#{Rails.root}/test/fixtures/google_transit_test_newyork.json"))
    @directions = @response["routes"][0]["legs"][0]["steps"]
  end

end

class GoogleTransitTest < ActiveSupport::TestCase

  test "can get price min" do
    g = GoogleTransit.new
    assert_equal nil, g.price_min
  end

  test "can get transit options" do
    g = GoogleTransit.new
    assert_equal "Bus", g.travel_type
  end

  test "can get minimum price" do
    g = GoogleTransit.new
    assert_equal nil, g.price_min
  end

  test "can get maximum price" do
    g = GoogleTransit.new
    assert_equal 1, g.price_max
  end

  test "can get eta" do
    g = GoogleTransit.new
    assert_equal 15, g.eta
  end

  test "can get options" do
    g = GoogleTransit.new
    assert_equal "Northgate/Guess Rd/Willowdale", g.options[0]["ride_name"]
    assert_equal 15, g.options[0]["total_eta"]
    assert_equal 15, g.options[0]["transit_time"]
    assert_equal 1, g.options[0]["price_max"]
    assert_equal nil, g.options[0]["price_min"]
  end

  test "can get departure time" do
    g = GoogleTransit.new
    assert_equal "3:12PM".to_time, g.departure_time
  end



end
