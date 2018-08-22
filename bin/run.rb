require_relative '../config/environment'


#sara = User.new(name: "Sara", max_price_range: 20, email: "Sarah.C@hotmail")
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

  puts "Please enter your full name"
  name = gets.strip.downcase
    if name == "exit"
      puts "Thank you for using Heard From a Friend, have a nice day."
      exit
    elsif name == "back"
      greeting

    end

  puts "Please enter an Email Address"
  email_address = gets.strip.downcase
    if email_address == "exit"
      puts "Thank you for using Heard From a Friend, have a nice day."
      exit
    elsif name == "back"
      greeting
    end

  new_user = nil
    if User.find_by(email: email_address) == nil
        new_user = User.create(name:name, email:email_address)

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
    main(new_user)
  end

  def existing

    puts "Please enter your email address"
    email_address = gets.chomp.downcase
<<<<<<< HEAD
      if email_address == "exit"
        puts "Thank you for using Heard From a Friend, have a nice day."
        exit
      end


=======
>>>>>>> 19071fcdc17a74de0f2cb336588b642de640bdeb
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
      current_user = User.find_by(email:email_address)
      main(current_user)
    end
  end

  def main(current_user)
    puts "Welcome #{current_user.name}"
    i = TTY::Prompt.new.select("Would you like to:") do |y|
      y.choices "See your saved activities?" => "saved_activities", "Look for something new to do?" => "add activities", "Update your profile" => "update", Exit: "exit"
    end

    case i
    when "saved_activities"
      saved_activities(current_user)
    when "add activities"
      add(current_user)
    when "update"
      update(current_user)
    when "exit"
      puts "Thank you for using, have a nice day."
      exit
    end
  end
<<<<<<< HEAD
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
          puts "Hope to see you again!"
          exit
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

=======
  # def update(user)
  #   i = TTY::Prompt.new.select("Would you like to:") do |y|
  #   y.choices "Update your Email?" => "email", "Update your name?" => "name", "Delete profile" => "delete", "Return to the main page?" => "main page", Exit: "exit"
  #   end
  #
  #   case i
  #   when "email"
  #     puts "What would you like to change your email to?"
  #       new_email = gets.chomp.downcase
  #       user.update(email: new_email)
  #     puts "Email updated!"
  #       update(user)
  #   when "name"
  #     puts "What would you like to change your name to?"
  #       new_name = gets.chomp.downcase
  #       user.update(name: new_name)
  #       puts "Name updated!"
  #         update(user)
  #   when "delete"
  #     puts "You sure you want to delete your profile?"
  #       t = TTY::Prompt.new.select("Would you like to:") do |y|
  #         y.choices "Yes" => "Yes", "No" => "No"
  #       end
  #
  #       case t
  #       when "Yes"
  #         user.destroy
  #         puts "Hope to see you again!"
>>>>>>> 19071fcdc17a74de0f2cb336588b642de640bdeb
  def saved_activities(user)
    all = user.activities
    g = all.map {|act| puts "#{act.place}, #{act.price}, #{act.genre}"}
    puts "Do you want to delete anything from your activity list?"
      response = gets.chomp.downcase
      binding.pry
      if response.include?("yes")
        puts "Okay, what would you like to delete?"
          delete(user)
      elsif "Would you like to add any events?"
        response_two = gets.chomp
        if response_two.include("yes")
          add(user)
        elsif response_two.include?("no")
          puts "Thank you for using! Have a great day!"
          exit
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
<<<<<<< HEAD

=======
>>>>>>> 19071fcdc17a74de0f2cb336588b642de640bdeb
  def delete(user)
    puts "What is the name of the event you would like to delete"
    name = gets.chomp.capitalize
    info = SavedActivity.find_by(user_id: user.id)
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
          puts "Hope to see you again!"
          exit
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

<<<<<<< HEAD

##############################   NEEDS SOME FRONT END WORK   #################################
  def saved_activities(user)
    all = user.activities
    g = all.map {|act| puts "Place: #{act.place}, Price: $#{act.price}, Genre: #{act.genre}"}
    puts "Would you like to delete any events?"
      response = gets.chomp
        if response.include?("yes")
          delete(user, g)
        elsif response.include("no")
          i = TTY::Prompt.new.select ("Great, wanna update anything else on your profile or look for a new event?") do |y| y.choices "Look for new Events" => "new events", "Update Profile" => "update", Exit: "exit"
          end
            case i
            when "new events"
              add(user)
            when "update"
              update(user)
            when "exit"
              puts "Thank you for using! Have a great day!"
              exit
            end
        end
  end




=======
>>>>>>> 19071fcdc17a74de0f2cb336588b642de640bdeb
  def add(user)
    i = TTY::Prompt.new.select("#{user.name}, what kind of activity are you in the mood for?") do |y|
      y.choices Concert: "Concert", Sports: "Sports", Dancing: "Dancing", Bar: "Bar", Museum: "Museum", Park:"Park", "Public Event" => "Public Event"
    end

      find_by_response(i,user)
  end


  def find_by_response(name,user)

    puts "How much would you like to spend?"
    number = gets.chomp.to_i
    puts `clear`
    selected_act = nil

    selected_act = Activity.select{|info|info.name == name && info.price <= number}

    if selected_act.length == 0
      puts "Sorry, nothing in your price range? Want to try again?"
        response = gets.chomp
        if response.include?("yes")
          find_by_response(name, user)
        elsif response.include?("no")
          puts "get more money"
            add(user)
        end
    else
    prompt = TTY::Prompt.new
    options = []
    selected_act.each {|act| options.push({name: "Place: #{act.place}, Price: $#{act.price}, Genre: #{act.genre}", value: act})}

    var = prompt.select("You picked", options)

    puts `clear`
    v = SavedActivity.create(user_id:user.id, activity_id:var.id)
<<<<<<< HEAD

=======
>>>>>>> 19071fcdc17a74de0f2cb336588b642de640bdeb
    puts "Activity saved in your profile! Do you want to look for more events?"
      response = gets.chomp.downcase
        if response.include?("yes")
          add(user)
        elsif response.include?("no")
          puts "Would you like to view your saved events?"
            response_two = gets.chomp.downcase
            if response_two.include?("yes")
              saved_activities(user)
            elsif response_two.include?("no")
              puts "Thank you for using! Have a great day!"
              exit
            end
        end
  end

greeting
