json.results do

  json.origin_address @rate_rider.origin_address
  json.destination_address @rate_rider.destination_address
  # need distance
  # need overview map

end

json.ride_sharing @options do |o|

  json.travel_type o.travel_type
  json.price_min o.price_min
  json.price_max o.price_max
  json.eta o.eta

  json.details do

    json.special_considerations o.special_considerations
    json.route_map o.route_map
    json.nearest_pickup_point o.nearest_pickup_point
    json.options o.options

  end

  json.start_journey_url o.start_journey_url

end


# json.lyft do
#
#   json.travel_type @lyft.travel_type
#   json.price_min @lyft.price_min
#   json.price_max @lyft.price_max
#   json.eta @lyft.eta
#
#   json.details do
#
#     json.special_considerations @lyft.special_considerations
#     json.route_map @lyft.route_map
#     json.nearest_pickup_point @lyft.nearest_pickup_point
#     json.options @lyft.options
#
#   end
#
#   json.start_journey_url @lyft.start_journey_url
#
# end
