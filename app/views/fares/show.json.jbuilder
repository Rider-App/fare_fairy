json.results do

  json.origin_address @rate_rider.origin_address
  json.destination_address @rate_rider.destination_address
  # need distance
  # need overview map

end

json.ride_sharing @ride_sharing do |o|

  json.travel_type o.travel_type
  json.price_min o.price_min
  json.price_max o.price_max
  json.eta o.eta

  json.details do

    json.special_considerations o.special_considerations
    json.route_map o.route_map
    json.nearest_pickup_point o.nearest_pickup_point
    json.ride_sharing o.options

  end

  json.start_journey_url o.start_journey_url

end

json.transit @transit do |o|

  json.travel_type o.travel_type
  json.price_min o.price_min
  json.price_max o.price_max
  json.eta o.eta

  json.details do

    json.special_considerations o.special_considerations
    json.route_map o.route_map
    json.nearest_pickup_point o.nearest_pickup_point
    json.transit o.options

  end

  json.start_journey_url o.start_journey_url

end
