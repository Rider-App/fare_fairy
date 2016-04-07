require 'test_helper'
require "#{Rails.root}/app/models/taxi_fare.rb"

class TaxiFare
  def initialize

    @nearest_city_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/taxi_fare_test_nearest.json"))
    @fare_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/taxi_fare_test_fare.json"))
    @companies_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/taxi_fare_test_companies.json"))

  end










end
