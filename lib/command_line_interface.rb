class CommandLineInterface

  def greet
    puts "Hello, what is your name?"
    answer = gets.chomp
    puts "Nice to have you #{answer}"
    find_or_create_by_name(answer)
  end

  # def create_user(name)
  #   User.create(name: name)
  # end

  def find_or_create_by_name(name)
    User.find_or_create_by(name: name)
  end


  def lunch_suggestion
    puts "Would you like a lunch suggestion? Yes/No?"
    answer = gets.chomp

    if answer == "Yes"
      # create new lunch instance
      Lunch.create(food_suggestion_id: food_suggestion_id, user_id: )
      #how to decide which food suggestion to put into a new lunch instance
      lunch = Lunch.new()
      puts "#{}"
    elsif answer == "No"
      puts "Ok have a good day."
    else
      puts "Enter a valid input."
      lunch_suggestion
    end
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

end
