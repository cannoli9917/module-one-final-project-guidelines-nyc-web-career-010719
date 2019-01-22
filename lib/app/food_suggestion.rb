class FoodSuggestion < ActiveRecord::Base
  has_many :lunches
  has_many :users, through: :lunches



  # be able to take in a user instance
  # be able to take in weather information from user location and API data
  # be able to return lunch suggestions based on location and weather
  #
#
#   response_string = RestClient.get('http://www.swapi.co/api/people/')
# response_hash = JSON.parse(response_string)

def whatever
  weather_string = RestClient.get("https://api.darksky.net/forecast/")

  weather_hash = JSON.parse(weather_string)
  binding.pry
end

end
