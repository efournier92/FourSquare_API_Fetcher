require 'foursquare2'
require 'yaml'
require_relative 'major_cities.rb'
require_relative 'retailers.rb'

CLIENT_ID     = '1DGJU00REBPY1WU5NC0C0TB4BP53MUNDPW4C4IKNVUUYWZ5T'
CLIENT_SECRET = 'W0YVFR4PLQUQFRLF4AY3L2WKFBV2DNK5M0SQ4BYQVFQVK5G2'

client = Foursquare2::Client.new(
  client_id:      CLIENT_ID,
  client_secret:  CLIENT_SECRET,
  api_version:   '20160511')
@retailer_array = []
RETAILERS.each do |retailer|
CITIES.each do |city|
  latitude = city[:latitude]
  longitude = city[:longitude]
  location = "#{latitude},#{longitude}"

  retailer_json  = client.search_venues(ll: location, query: retailer)

  retailer_json.venues.each do |retailer_in_city|
    retailer_info = {}
    retailer_info.merge!(retailer:   retailer_in_city.name)
    retailer_info.merge!(id:         retailer_in_city.id)
    retailer_info.merge!(zip:        retailer_in_city.location.postalCode)
    retailer_info.merge!(checkins:   retailer_in_city.stats.checkinsCount)
    retailer_info.merge!(usersCount: retailer_in_city.stats.usersCount)
    retailer_info.merge!(tipCount:   retailer_in_city.stats.tipCount)
    @retailer_info = retailer_info
  end
  @retailer_array << @retailer_info
end
end

File.open("data.yml","w") do |file|
   file.write @retailer_array.to_yaml
end
