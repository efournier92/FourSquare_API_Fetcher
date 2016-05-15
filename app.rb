require_relative 'lib/major_city_coordinates.rb'
require_relative 'lib/retailers_of_interest.rb'
require 'foursquare2'
require 'yaml'
require 'pry'

CLIENT_ID     = ''
CLIENT_SECRET = ''

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
    binding.pry
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
