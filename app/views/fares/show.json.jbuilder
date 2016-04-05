json.results do

  json.origin_address @origin
  json.destination_address @destination
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
