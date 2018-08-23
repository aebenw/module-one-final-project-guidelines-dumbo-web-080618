require_relative '../config/environment'



def greeting
  prompt = TTY::Prompt.new.select("Welcome to Heard From a Friend.") do |y|
    y.choices "Sign in": "existing", "New Member" => "signup", Exit: "exit"
  end

  case prompt

  when "existing"
    existing

  when "signup"
    signup

  when "exit"
    puts "Enjoy your day!"
    exit
  end
end

def signup
  puts "Please enter an Email Address"
  email_address = gets.strip.downcase
  if email_address == "exit"
    puts "Thank you for using Heard From a Friend, have a nice day."
    exit
  end
  if EmailAddress.valid?(email_address) != true
    puts "That was an invalid email address format,please try again"
    signup
  else
    puts "Please enter your full name"
    name = gets.strip.downcase
      if name == "exit"
        puts "Thank you for using Heard From a Friend, have a nice day."
        exit
      end

  new_user = nil
    if User.find_by(email: email_address) == nil
        new_user = User.create(name:name, email:email_address)
        ################## figure out if they want to try the same email again/ try signing in ##################
      else
        i = TTY::Prompt.new.select("Sorry, that email address is already in use with another account. Would you like to:") do |y|
          y.choices "Sign in with existing account?": "existing", "Make a new account?" => "signup", Exit: "exit"
        end

          case i
          when "existing"
            existing
          when "signup"
            signup
          when "exit"
            puts "Thank you for using, have a nice day."
            exit
          end
      end
    end
    main(new_user)
  end

  def existing

    puts "Please enter your email address"
    email_address = gets.chomp.downcase
    if !User.find_by(email:email_address)
      i = TTY::Prompt.new.select("Sorry, we can't seem to find the email address you entered. Would you like to:") do |y|
        y.choices "Try again?" => "existing", "Make a new account?" => "signup", Exit: "exit"
      end

        case i
        when "existing"
          existing
        when "signup"
          signup
        when "exit"
          puts "Thank you for using, have a nice day."
          exit
        end
    else
      user = User.find_by(email:email_address)
      main(user)
    end
  end

  def main(user)
    puts "Welcome #{user.name.capitalize}"
    i = TTY::Prompt.new.select("Would you like to:") do |y|
      y.choices "See your saved activities?" => "saved_activities", "Look for something new to do?" => "add activities", "Update your profile." => "update", Exit: "exit"
      #=================================MAYBE WE CAN CHANGE SAVED ACTIVITIES TO  "WOULD YOU LIKE TO SEE YOUR HISTORY " AS AN OPTION ==================================================
    end

    case i
    when "saved_activities"
      saved_activities(user)
    when "add activities"
      add(user)
    when "exit"
      puts "Thank you for using Heard From a Friend, have a nice day."
      exit
    when "update"
      update(user)
    end
  end

  def saved_activities(user)
    # user.reload
    all = user.activities
    results = []
    #binding.pry
    if all.length == 0
      prompt = TTY::Prompt.new.select("Nothing in your saved activities, do you want to search for some?") do |y|
        y.choices "Yes": "yes", "No, sign me out" => "exit"
      end
        case prompt
        when "yes"
        add(user)
        when "no"
        puts "Thanks for using! Have a great day."
        exit
      end
    else
    g = all.each_with_index { |act, i| results.push(puts " #{i + 1}. Place: #{act.place},  Price :#{act.price},  Genre:#{act.genre}")}
    #binding.pry
    puts "Do you want to delete anything from your activity list?"
      response = gets.chomp.downcase
      if response.include?("yes")
          delete(user)
      elsif response.include?("no")
            puts "Would you like to add any events?"
              response_two = gets.chomp
              if response_two.include?("yes")
                add(user)
              elsif response_two.include?("no")
                i = TTY::Prompt.new.select("Would you like to:") do |y|
                  y.choices "Go back to your saved activites?" => "saved_activities", "Exit?" => "exit"
                end
                case i
                when "saved_activities"
                  saved_activities(user)
                when "exit"
                  puts "Thank you so much for using Heard from a Friend. Have a nice day!"
                  exit
                end
            end
          end
        end
      end

  def delete(user)
    # user.reload
    user_a= user.activities
    prompt = TTY::Prompt.new
    options = []
    user_a.each {|act| options.push({name:"Place:#{act.place}, Price:#{act.price}, Genre:#{act.genre}", value: act})}
    var = prompt.select("You choose to delete", options)
    #

    i = TTY::Prompt.new.select("Are you sure you want to delete this activity?") do |y|
      y.choices Yes: "yes", No: "no"
    end
    case i
    when "yes"
      #binding.pry
      del = SavedActivity.where(user_id:user.id, activity_id:var.id).destroy_all
      #binding.pry
      user.activities = user.activities.select {|act| act.id != var.id}
      user.activities
      saved_activities(user)
      # SavedActivity.delete
    when "no"
      puts "That's ok, we all make mistakes."
      saved_activities(user)
    end

  end


  def update(user)
    i = TTY::Prompt.new.select("Would you like to:") do |y|
    y.choices "Update your Email?" => "email", "Update your name?" => "name", "Delete profile" => "delete", "Return to the main page?" => "main page", Exit: "exit"
    end

    case i
    when "email"
      puts "What would you like to change your email to?"
        new_email = gets.chomp.downcase
        user.update(email: new_email)
      puts "Email updated!"
        update(user)
    when "name"
      puts "What would you like to change your name to?"
        new_name = gets.chomp.downcase
        user.update(name: new_name)
        puts "Name updated!"
          update(user)
    when "delete"
      puts "You sure you want to delete your profile?"
        t = TTY::Prompt.new.select("Would you like to:") do |y|
          y.choices "Yes" => "Yes", "No" => "No"
        end

        case t
        when "Yes"
          user.destroy
          greeting
        when "No"
          puts "We were afraid we almost lost you there."
          main(user)
        end

    when "main page"
      main(user)
    when "exit"
      puts "Thank you for using, have a nice day."
      exit
    end
  end



  def add(user)
    i = TTY::Prompt.new.select("#{user.name}, what kind of activity are you in the mood for?") do |y|
      y.choices Concert: "Concert", Sports: "Sports", Dancing: "Dancing", Bar: "Bar", Museum: "Museum", Park:"Park", "Public Event" => "Public Event"
    end

      find_by_response(i,user)
  end


  def find_by_response(name,user)

    puts "How much would you like to spend?"
    number = gets.chomp.to_i

    ############# ************ I think a bug will occur if a string is typed  *************** ############

    puts `clear`
    selected_act = Activity.select{|info|info.name == name && info.price <= number}
    if selected_act.length == 0
      i = TTY::Prompt.new.select("Sorry, nothing in your price range =/. Do you want to:") do |y|
        y.choices "Search for another activity?" => "events", "Go back to home page" => "main", "Log out" =>  "exit"
      end
      case i
      when "events"
        add(user)
      when "main"
        main(user)
      when "exit"
        puts "Thank you for using!"
        exit
      end
  else
    prompt = TTY::Prompt.new
    options = []
      ##################### How do we make it into a table??? ####################
    selected_act.each {|act| options.push({name: "Place: #{act.place}, Price: #{act.price}, Type: #{act.genre}, Best Time to Go: #{act.best_time}", value: act})}
    var = prompt.select("Here are your options:", options)

    puts `clear`
    v = SavedActivity.create(user_id:user.id, activity_id:var.id)
    # g = Activity.find(var.id)
    user.reload

    i = TTY::Prompt.new.select("Activity saved in your profile! Do you want to:") do |y|
      y.choices "Look for more events?" => "events", "See saved activities?" => "saved_events", "Log out?" => "exit"
    end

        case i
        when "events"
          add(user)
        when "saved_events"
          saved_activities(user)
        when "exit"
          puts "Come back soon!"
          exit
        end
      end
  end

signup
