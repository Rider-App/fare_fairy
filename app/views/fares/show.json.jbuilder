json.results do

  json.origin_address @rate_rider.origin_address
  json.destination_address @rate_rider.destination_address
  # need distance
  # need overview map

end

json.uber do

  json.travel_type @uber.travel_type
  json.price_min @uber.price_min
  json.price_max @uber.price_max
  json.eta @uber.eta

  json.details do

    json.special_considerations @uber.special_considerations
    json.route_map @uber.route_map
    json.nearest_pickup_point @uber.nearest_pickup_point
    json.options @uber.options

  end

  json.start_journey_url @uber.start_journey_url

end


json.lyft do

  json.travel_type @lyft.travel_type
  json.price_min @lyft.price_min
  json.price_max @lyft.price_max
  json.eta @lyft.eta

  json.details do

    json.special_considerations @lyft.special_considerations
    json.route_map @lyft.route_map
    json.nearest_pickup_point @lyft.nearest_pickup_point
    json.options @lyft.options

  end

  json.start_journey_url @lyft.start_journey_url

end
