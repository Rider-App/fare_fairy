require 'test_helper'
require "#{Rails.root}/app/models/taxi_fare.rb"

class TaxiFare
  def initialize

    @nearest_city_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/taxi_fare_test_nearest.json"))
    @fare_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/taxi_fare_test_fare.json"))
    @companies_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/taxi_fare_test_companies.json"))

  end
end

class TaxiFareTest < ActiveSupport::TestCase

  test "assert true" do
    true
  end

  test "travel type" do
    tf = TaxiFare.new
    assert_equal "Taxi", tf.travel_type
  end

  test "can get total fare" do
    tf = TaxiFare.new
    assert_equal 29, tf.total_fare
  end

  test "can get extra charges" do
    tf = TaxiFare.new
    assert_equal 7.5, tf.extra_charges
  end

  test "can get reasonable tip amount" do
    tf = TaxiFare.new
    assert_equal 5, tf.tip_amount
  end

  test "can get price min" do
    tf = TaxiFare.new
    assert_equal 23, tf.price_min
  end

  test "can get price max" do
    tf = TaxiFare.new
    assert_equal 28, tf.price_max
  end

  test "can get eta" do
    tf = TaxiFare.new
    assert_equal "N/A", tf.eta
  end

  test "can get special considerations" do
    tf = TaxiFare.new
    assert_equal [{"charge"=>5.25, "description"=>"Harbor Tunnel Tolls"}, {"charge"=>2.25, "description"=>"Logan Airport Fee"}], tf.special_considerations
  end

  test "can get options hash" do
    tf = TaxiFare.new
    assert_equal [{"ride_name"=>"Local taxi", "price_min"=> 23, "price_max"=> 28, "eta_estimates"=> "N/A", "transit_time"=> "N/A", "pickup_eta"=>"N/A"}], tf.options
  end

  test "can get one taxi co name and number" do
    tf = TaxiFare.new
    assert_equal ["CabCo1", "123-456-7890"], tf.call_one_cab
  end

  test "can get all taxi co names and numbers" do
    tf = TaxiFare.new
    assert_equal [{name: "CabCo1", phone: "123-456-7890"}, {name: "CabCo2", phone: "098-765-4321"}], tf.call_all_cabs
  end












end
