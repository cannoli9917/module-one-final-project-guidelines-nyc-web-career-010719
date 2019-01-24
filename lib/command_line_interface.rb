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
      --D--  Delete my account
    "
    answer = gets.chomp
    if answer == "A"
      lunch_suggestion
    elsif answer == "B"
      view_lunch_favorites
    elsif answer == "C"
      view_lunch_history
    elsif answer == "D"
      delete_account
    else puts "Please select from the following list"
      menu
    end
  end


  def lunch_suggestion
      lunch = Lunch.create(food_suggestion_id: food_suggestion_id, user_id: @person.id)
# display lunch
# ask if you want to add to favorites
      # id = lunch.food_suggestion_id
      # when food_suggestion_id == FoodSuggestion.id

      fs = FoodSuggestion.where(id: lunch.food_suggestion_id)
      place = fs.pluck(:suggestion)
      distance = fs.pluck(:distance)



    # binding.pry
      puts "It's #{current_temperature} degrees F. #{place[0]} is a great place #{distance[0]}."
      puts "Would you like to add #{place[0]} to your favorites list? Yes/No"
      answer = gets.chomp
      if answer == "Yes"
        add_favorite(lunch)
        puts "#{place[0]} was added to your favorites."
      else
        puts "Okay, sounds good! #{place[0]} was not added to your favorites."
      end
  end

  def add_favorite(lunch)
    lunch.update(is_favorite: 1)
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
    favorite_lunches = @person.lunches.where(is_favorite: 1)
    places = favorite_lunches.map do |lunch|
      lunch.food_suggestion.suggestion
    end.uniq

    puts "Here are your favorite places:"
    places.each do |place|
      puts place
    end
  end

  def view_lunch_history
    history = Lunch.where(user_id: @person.id)

    fs_ids = history.pluck(:food_suggestion_id)
    places = FoodSuggestion.where(id: fs_ids)
    my_places = places.pluck(:suggestion)
    puts "Here is your lunch history:"
    my_places.each do |place|
      puts place
    end
  end

  def delete_account
    puts "Are you sure you want to delete your account? Yes/No"
    answer = gets.chomp
    if answer == "Yes"
      User.destroy(@person.id)
      puts "Okay, bye! You're deleted."
      exit
    else
      puts "That's good."
      menu
    end
  end


end
