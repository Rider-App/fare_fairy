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

  test "can get nearest city" do
    tf = TaxiFare.new
    assert_equal "Boston", tf.entity_handle
  end

  test "can get total fare" do
    tf = TaxiFare.new
    assert_equal 27.11, tf.total_fare
  end

  test "can get extra charges" do
    tf = TaxiFare.new
    assert_equal 7.5, tf.extra_charges
  end



end
