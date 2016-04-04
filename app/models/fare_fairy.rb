class FareFairy
  attr_reader :response
  
  def initialize(origin, destination)
    origin = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{origin}")
    destination = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{destination}")
    if multiple_results?(origin)
      @response = formatted_addresses(origin)
    else
      @response = Transit.new("#{lat(origin)}, #{long(origin)}", "#{lat(destination)}, #{long(destination)}")
    end
  end

  def multiple_results?(response)
    true if response["results"].length > 1
  end

  def formatted_addresses(response)
    response["results"].map {|r| r["formatted_address"]}
  end

  def location_data(response)
    response["results"].first["geometry"]["location"]
  end

  def lat(response)
    location_data(response)["lat"]
  end

  def long(response)
    location_data(response)["lng"]
  end


end
