require 'test_helper'
require "#{Rails.root}/app/models/uber.rb"

class Uber
  def initialize
    @prices = JSON.parse(File.read("#{Rails.root}/test/models/uber_price_test.json"))
    @times = JSON.parse(File.read("#{Rails.root}/test/models/uber_time_test.json"))
  end
end

class UberTest < ActiveSupport::TestCase

  test "uber class exists" do
    assert Uber
  end

  test "uber price min" do
    uber = Uber.new
    assert_equal 37, uber.price_min
  end

  test "uber price max" do
    uber = Uber.new
    assert_equal 79, uber.price_max
  end

  test "uber eta" do
    uber = Uber.new
    assert_equal 37, uber.eta
  end

  test "uber special considerations" do
    uber = Uber.new
    assert_equal "surge pricing", uber.special_considerations
  end

  test "uber options" do
    uber = Uber.new
    assert_equal "uberX", uber.options[0][:ride_name]
    assert_equal 37, uber.options[1][:price_min]
    assert_equal 66, uber.options[2][:price_max]
    assert_equal 37, uber.options[1][:total_eta]
  end

end
