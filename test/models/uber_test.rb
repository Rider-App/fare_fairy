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

end
