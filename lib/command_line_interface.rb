class CommandLineInterface

  def greet


    puts "

                              Hello, what is your name?

                                                                      "
    answer = gets.chomp
    puts "

                              Nice to have you #{answer}
                                                                      "
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
                            --E--  Exit
    "
    answer = gets.chomp
    if answer.upcase == "A"
      lunch_suggestion
    elsif answer.upcase == "B"
      view_lunch_favorites
    elsif answer.upcase == "C"
      view_lunch_history
    elsif answer.upcase == "D"
      delete_account
    elsif answer.upcase == "E"
      exit
    else puts "

                        Please select from the following list
                                                                    "
      menu
    end
  end


  def lunch_suggestion
      lunch = Lunch.create(food_suggestion_id: food_suggestion_id, user_id: @person.id, date: Time.now.strftime("%B %d, %Y"))

      place = lunch.food_suggestion.suggestion
      distance = lunch.food_suggestion.distance

      puts "
          Weather today : #{current_weather_summary}
          It's #{current_temperature} degrees F. #{place} is a great place #{distance}.
                                                                                  "


      favorite_lunches = @person.lunches.where(is_favorite: 1)
      places = favorite_lunches.map do |lunch|
        lunch.food_suggestion.suggestion
      end.uniq

      if places.include?(place)

        puts "
                  #{place} is one of your favorite places.  Enjoy your lunch!
                                                                                  "
          menu
      else puts "
                Would you like to add #{place} to your favorites list? Yes/No
                                                                                  "
      end
      answer = gets.chomp
      if answer.downcase == "yes"
        add_favorite(lunch)
        puts "
                      #{place} was added to your favorites.
                                                                                  "
      else
        puts "
                Okay, sounds good! #{place} was not added to your favorites.
                                                                                  "
      end
      menu
  end

  def add_favorite(lunch)
    lunch.update(is_favorite: 1)
  end


  def current_temperature
    weather_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['API_KEY']}/40.705311,-74.014053")

    weather_hash = JSON.parse(weather_string)

    weather_hash["currently"]["temperature"]
  end


  def current_precipitation_probability
    weather_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['API_KEY']}/40.705311,-74.014053")

    weather_hash = JSON.parse(weather_string)

    weather_hash["currently"]["precipProbability"]

  end

  def current_weather_summary
    weather_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['API_KEY']}/40.705311,-74.014053")

    weather_hash = JSON.parse(weather_string)

    weather_hash["currently"]["summary"]

  end

  def food_suggestion_distance
    if current_temperature < 30 || current_precipitation_probability > 0.7
      return "in the building"
    elsif current_temperature > 50 || current_precipitation_probability < 0.5
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

    if places.size > 0
        puts "
                                Here are your favorite places:
                                                                          "
        places.each do |place|
          puts place
        end

        remove_favorite?
    else
      puts "
                                You have no favorite places!
                                                                            "
      menu
    end

  end


  def remove_favorite?
    favorite_lunches = @person.lunches.where(is_favorite: 1)
    places = favorite_lunches.map do |lunch|
      lunch.food_suggestion.suggestion
    end.uniq
    puts "
    Would you like to remove any of these places from your favorites?
    Yes/No
    "
    answer = gets.chomp
    if answer.downcase == "yes"
      puts  "
      Which favorite would you like to remove?
      "
      answer = gets.chomp
      if places.include?(answer)

        lunch_obj = favorite_lunches.select do |lunch|
          lunch.food_suggestion.suggestion == answer
        end

        lunch_obj.each do |lunch|
          lunch.update(is_favorite: 0)
        end
        view_lunch_favorites
      else
        puts "Please enter a favorite restaurant you would like to remove."
        remove_favorite?
      end
    else
      menu
    end
  end

  def view_lunch_history
    historys = @person.lunches.map do |lunch|
      "#{lunch.date} - #{lunch.food_suggestion.suggestion}"
    end

    if historys.size > 0

      puts "
                              Here is your lunch history:
                                                                      "
      historys.each do |place|
        puts place
      end

      menu

    else
      puts "
                              You have no lunch history!
                                                                          "
      menu
    end
  end

  def delete_account
    puts "
              Are you sure you want to delete your account? Yes/No
                                                                    "
    answer = gets.chomp
    if answer.downcase == "yes"
      User.destroy(@person.id)
      puts "
                            Okay, bye! You're deleted.
                                                                    "
      exit
    else
      puts "
                                  That's good.
                                                                    "
      menu
    end
  end


end
