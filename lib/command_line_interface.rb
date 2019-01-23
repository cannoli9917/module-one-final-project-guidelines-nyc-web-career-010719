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
      lunch = Lunch.new()
      puts "#{}"
    elsif answer == "No"
      puts "Ok have a good day."
    else
      puts "Enter a valid input."
      lunch_suggestion
    end
  end

  # OUr user wants to know where to go to lunch today based on the weather

end
