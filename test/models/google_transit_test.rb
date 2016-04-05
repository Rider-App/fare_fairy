require 'test_helper'
require "#{Rails.root}/app/models/google_transit.rb"

class GoogleTransit
  def initialize

  end

end

class GoogleTransitTest < ActiveSupport::TestCase

  test "can get price min" do
    g = GoogleTransit.new
    assert_equal nil, g.price_min
  end
end
