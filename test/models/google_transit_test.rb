require 'test_helper'
require "#{Rails.root}/app/models/google_transit.rb"

class GoogleTransit
  def initialize
    response = JSON.parse(File.read("#{Rails.root}/test/fixtures/google_transit_test_durham.json"))
    @directions = response["routes"][0]["legs"][0]["steps"]
  end

end

class GoogleTransitTest < ActiveSupport::TestCase

  test "can get price min" do
    g = GoogleTransit.new
    assert_equal nil, g.price_min
  end

  test "can get transit options" do
    g = GoogleTransit.new
    assert_equal "Subway", g.travel_type
  end



end
