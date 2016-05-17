#FourSquare Data Fetcher

This is an app I wrote in preparation for a Boston quant finance hackathon, with the intention of using FourSquare data to provide future stock projections.

The app uses a Ruby wrapper for the FourSquare API to fetch data for 10 retailers (listed in `lib/retailers_of_interest.rb`). The data is pulled for stores in each of the 80 most populace cities in US and Canada (listed in `lib/major_city_coordinates.rb`).

###Persisted Data Points
* retailer name
* id
* zip
* checkins (today)
* usersCount (today)
* tipCount (today)

Data is fetched in JSON format, and the points of interest is persisted in a new  YML file within `lib`, containing today's date.
