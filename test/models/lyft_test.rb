require 'test_helper'
require "#{Rails.root}/app/models/lyft.rb"

class Lyft
  def initialize


    @auth_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/lyft_test_auth.json"))
    @token = @auth_response["access_token"]

    @cost_response = JSON.parse(File.read("#{Rails.root}/test/fixtures/lyft_cost.json"))



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

  # test "prince_min" do
  # end
  #
  # test "assert price max" do
  # end
  #
  # test "assert ride ETA" do
  # end
  #
  # test "can get details" do
  # end
  #
  # test "can get special considerations" do
  # end
  #
  # test "can get root map" do
  # end
  #
  # test "can get nearest pickup point" do
  # end
  #
  # test "can get options" do
  # end
  #
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
