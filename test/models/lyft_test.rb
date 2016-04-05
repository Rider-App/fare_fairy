require 'test_helper'
require "#{Rails.root}/app/models/lyft.rb"

class Lyft
  def initialize
    @auth_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/lyft_test_auth.json"))
    @cost_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/lyft_cost.json"))
end

class LyftTest < ActiveSupport::TestCase

  test "assert the truth" do
    true
  end

  


end
