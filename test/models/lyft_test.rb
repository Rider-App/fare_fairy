require 'test_helper'
require "#{Rails.root}/app/models/lyft.rb"

class Lyft
  def initialize

    @auth_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/lyft_test_auth.json"))
    @token = @auth_response["access_token"]

    @cost_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/lyft_cost.json"))

    @eta_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/lyft_test_eta.json"))

  end
end

class LyftTest < ActiveSupport::TestCase

  test "assert token" do
    l = Lyft.new
    assert_equal "gAAAAABXA782w7Rl0I1ZjR37xrp_1tQ2NyCPm2LFh7YEXen5ryMq7zJ-mlBjMQCht-vJ6aOwfsdBWOGCFGg0q8VshBCqQ2AX-wnc9V7uJ-_8Ld95NxpvgjKNnLyqg-zg6LvjP8Q7HufcxgXQrlao9jaCix9zbwJCub_PGZBIr09axNk0uekInITlAveCG5xBLWOLLj4-EuIU8UUcdchQncJmDLfZBmheeQ==", l.token
  end

  test "travel type" do
    l = Lyft.new
    assert_equal "lyft", l.travel_type
  end

  test "price_min" do
    l = Lyft.new
    assert_equal 7.14, l.price_min
  end

  test "assert price max" do
    l = Lyft.new
    assert_equal 19.51, l.price_max
  end

  test "assert ride ETA" do
    l = Lyft.new
    assert_equal 20, l.eta
  end

  test "can get special considerations" do
    l = Lyft.new
    assert_equal "none", l.special_considerations
  end

  test "can get options" do
    l = Lyft.new
    assert_equal "Lyft", l.options[0]["ride_name"]
    assert_equal 20, l.options[0]["total_eta"]
    assert_equal 6, l.options[0]["pickup_eta"]
    assert_equal 14, l.options[1]["transit_time"]
    assert_equal 7.14, l.options[2]["price_max"]
  end

  # test "can get start journey URL" do
  # end
  #
  # test "can get ride name" do
  # end
  #
  # test "can get price" do
  # end
  #
  # test "can get pickup ETA" do
  # end
  #
  # test "can get transit time" do
  # end
  #
  # test "can get total ETA" do
  # end

end
