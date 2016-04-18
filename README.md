## Overview

Fare Fairy is an API that integrates with Uber, Lyft, Taxi Fare Finder and Google Maps Directions APIs all at once. The Fare Fairy takes starting and destination addresses, converts them into latitude and longitude, gets estimates for time and cost from each transit API, then reports them back in one cohesive package. Because she's helpful like that.

See Fare Fairy in action at [farefairy.us](http://farefairy.us).

This app served as the final project of Cohort 6 at The Iron Yard, and was initially built to support the needs of [Rider](http://riderapp.us), but it's now available to anyone who wants to use the data. If you'd like more information or access to the API, feel free to contact any of the contributors to this repository.

## Documentation

Full documentation of the API and its endpoints is available on the [Fare Fairy site](http://farefairy.herokuapp.com/documentation).

The core endpoint for the Fare Fairy API is the `fares` endpoint, which will return transit data based on a starting and ending address.

### Sample API Call

To get fare data, post a `GET` request to `http://farefairy.herokuapp.com/api/v1/fares`.

The API takes two parameters, `origin` address and `destination` address.

A sample call for directions from the Empire State Building to JFK Airport would look like this:

http://farefairy.herokuapp.com/api/v1/fares?origin=350%205th%20Ave,%20New%20York,%20NY%2010118&destination=JFK%20Queens,%20NY%2011430

And a sample result is:

```
{
"results": {
"origin_address": "350 5th Ave, New York, NY 10118",
"destination_address": "John F. Kennedy International Airport (JFK), Queens, NY 11430, USA",
"origin_lat": 40.7484799,
"origin_lng": -73.9854246,
"destination_lat": 40.6413111,
"destination_lng": -73.77813909999999
},
"ride_sharing": [
{
"travel_type": "Uber",
"has_details": true,
"price_min": 50,
"price_max": 160,
"eta": 51,
"details": {
"special_considerations": "none",
"route_map": "",
"nearest_pickup_point": "",
"ride_sharing": [
{
"ride_name": "uberX",
"price_min": 50,
"price_max": 65,
"pickup_eta": 3,
"transit_time": 49,
"total_eta": 52
},
{
"ride_name": "uberXL",
"price_min": 75,
"price_max": 98,
"pickup_eta": 4,
"transit_time": 49,
"total_eta": 53
},
{
"ride_name": "uberFAMILY",
"price_min": 60,
"price_max": 75,
"pickup_eta": 4,
"transit_time": 49,
"total_eta": 53
},
{
"ride_name": "UberBLACK",
"price_min": 99,
"price_max": 128,
"pickup_eta": 2,
"transit_time": 49,
"total_eta": 51
},
{
"ride_name": "UberSUV",
"price_min": 124,
"price_max": 160,
"pickup_eta": 2,
"transit_time": 49,
"total_eta": 51
},
{
"ride_name": "Yellow WAV",
"price_min": 0,
"price_max": 0,
"pickup_eta": 9,
"transit_time": 49,
"total_eta": 58
},
{
"ride_name": "uberT",
"price_min": null,
"price_max": null,
"pickup_eta": 4,
"transit_time": 49,
"total_eta": 53
}
]
},
"start_journey_url": "uber://?action=setPickup&pickup[latitude]=40.7484799&pickup[longitude]=-73.9854246&dropoff[latitude]=40.6413111&dropoff[longitude]=-73.77813909999999&client_id=0BPqxqD4jlZ9D5Umi73vshGplBDg_OR0",
"iphone_app_url": "https://m.uber.com/sign-up?client_id=0BPqxqD4jlZ9D5Umi73vshGplBDg_OR0",
"android_app_url": "https://m.uber.com/sign-up?client_id=0BPqxqD4jlZ9D5Umi73vshGplBDg_OR0"
},
{
"travel_type": "Lyft",
"has_details": true,
"price_min": 45,
"price_max": 94,
"eta": 42,
"details": {
"special_considerations": "none",
"route_map": "",
"nearest_pickup_point": "",
"ride_sharing": [
{
"ride_name": "Lyft Plus",
"price_min": 69,
"price_max": 94,
"pickup_eta": 3,
"transit_time": 40,
"total_eta": 43
},
{
"ride_name": "Lyft Line",
"price_min": 46,
"price_max": 47,
"pickup_eta": 2,
"transit_time": 40,
"total_eta": 42
},
{
"ride_name": "Lyft",
"price_min": 45,
"price_max": 62,
"pickup_eta": 2,
"transit_time": 40,
"total_eta": 42
}
]
},
"start_journey_url": "lyft://ridetype?id=lyft&pickup[latitude]=40.7484799&pickup[longitude]=-73.9854246&destination[latitude]=40.6413111&destination[longitude]=-73.77813909999999&partner=cYxhe05agooR",
"iphone_app_url": "https://itunes.apple.com/us/app/lyft-taxi-bus-app-alternative/id529379082",
"android_app_url": "https://play.google.com/store/apps/details?id=me.lyft.android"
}
],
"transit": [
{
"travel_type": "Subway + Light rail",
"has_details": true,
"price_min": null,
"price_max": null,
"eta": 60,
"details": {
"special_considerations": "none",
"route_map": "",
"nearest_pickup_point": "",
"transit": [
{
"ride_name": "Lexington Avenue Local",
"short_name": "6",
"price_min": null,
"price_max": null,
"pickup_eta": 11,
"transit_time": 4,
"total_eta": 60
},
{
"ride_name": "8 Avenue Local",
"short_name": "E",
"price_min": null,
"price_max": null,
"pickup_eta": 19,
"transit_time": 27,
"total_eta": 60
},
{
"ride_name": "AirTrain JFK Red",
"short_name": null,
"price_min": null,
"price_max": null,
"pickup_eta": 57,
"transit_time": 9,
"total_eta": 60
}
]
},
"start_journey_url": "http://maps.google.com?saddr=350+5th+Ave,+New+York,+NY+10118&daddr=JFK+Queens,+NY+11430&directionsmode=transit"
},
{
"travel_type": "Bus + Light rail",
"has_details": true,
"price_min": null,
"price_max": null,
"eta": 97,
"details": {
"special_considerations": "none",
"route_map": "",
"nearest_pickup_point": "",
"transit": [
{
"ride_name": "Glen Oaks - Midtown",
"short_name": "QM5",
"price_min": null,
"price_max": null,
"pickup_eta": 14,
"transit_time": 47,
"total_eta": 97
},
{
"ride_name": "127 Street - Kissena Bl - Parsons Bl",
"short_name": "Q25",
"price_min": null,
"price_max": null,
"pickup_eta": 68,
"transit_time": 15,
"total_eta": 97
},
{
"ride_name": "AirTrain JFK Red",
"short_name": null,
"price_min": null,
"price_max": null,
"pickup_eta": 94,
"transit_time": 9,
"total_eta": 97
}
]
},
"start_journey_url": "http://maps.google.com?saddr=350+5th+Ave,+New+York,+NY+10118&daddr=JFK+Queens,+NY+11430&directionsmode=transit"
}
],
"taxis": [
{
"travel_type": "Taxi",
"has_details": true,
"price_min": 51,
"price_max": 63,
"eta": "N/A",
"details": {
"special_considerations": [
{
"charge": 0.5,
"description": "NY State Tax Surcharge"
},
{
"charge": 0.3,
"description": "NY Improvement Surcharge"
}
],
"route_map": "",
"nearest_pickup_point": "",
"taxis": [
{
"ride_name": "Local taxi",
"price_min": 51,
"price_max": 63,
"eta_estimates": "N/A",
"transit_time": "N/A",
"pickup_eta": "N/A"
}
],
"contact_info": []
},
"start_journey_url": ""
}
]
}
```
