class CommandLineInterface

  def greet
    puts "Hello, what is your name?"
    answer = gets.chomp
    puts "Nice to have you #{answer}"
    @person = find_or_create_by_name(answer)
    @person
  end


  def find_or_create_by_name(name)
    User.find_or_create_by(name: name)
  end


  def menu
    puts "
    What would you like to do?
      --A--  Give me a lunch suggestion
      --B--  See my lunch favorites
      --C--  View my lunch history
      --D--  Go to My Settings
    "
    answer = gets.chomp
    if answer == "A"
      lunch_suggestion
    elsif answer == "B"
      view_lunch_favorites
    elsif answer == "C"
      view_lunch_history
    elsif answer == "D"
      settings_menu
    else puts "Please select from the following list"
      menu
    end
  end


  def lunch_suggestion
      Lunch.create(food_suggestion_id: food_suggestion_id, user_id: @person.id)
# display lunch
# ask if you want to add to favorites
      puts "#{}"
  end


  def current_temperature
    weather_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['API_KEY']}/40.705311,-74.014053")

    weather_hash = JSON.parse(weather_string)

    weather_hash["currently"]["temperature"]
  end

  def food_suggestion_distance
    if current_temperature < 30
      return "in the building"
    elsif current_temperature > 50
      return "in the neighborhood"
    else
      return "nearby"
    end
  end

  def food_suggestion_id
    fs = FoodSuggestion.where(distance: food_suggestion_distance)
    fs.sample.id
  end

  # OUr user wants to know where to go to lunch today based on the weather

  def view_lunch_favorites
  end

  def view_lunch_history
  end

  def settings_menu
  end


end
