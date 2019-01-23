class FoodSuggestion < ActiveRecord::Base
  has_many :lunches
  has_many :users, through: :lunches



  # be able to take in a user instance

  # be able to return lunch suggestions based on location and weather
  #


  ## be able to take in weather information from flatiron school location and API data
  def current_temperature
    weather_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['API_KEY']}/40.705311,-74.014053")

    weather_hash = JSON.parse(weather_string)

    weather_hash["currently"]["temperature"]

  end


  #take the weather_hash and return boolean is_precipitating?
  #if currently icon == "rain"

  # determines lunch place based on temperature
  # but if it's raining

end
