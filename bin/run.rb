require_relative '../config/environment'

class String
 # colorization
 def colorize(color_code)
   "\e[#{color_code}m#{self}\e[0m"
 end

 def red
   colorize(31)
 end

 def green
   colorize(32)
 end

 def yellow
   colorize(33)
 end

 def blue
   colorize(34)
 end

 def pink
   colorize(35)
 end

 def light_blue
   colorize(36)
 end
end

def hello_kitty
  puts `clear`
  puts "░░░░░░░▄▀▀▀▀█░░░░░░░░░░░░░░░░░░░░
░░░░░░█▀░░░░█░░░░░░░░░░░░░░░░░░░░
░░░░░█░░░░░░█▀▀▀▄▄░░░░░░▓░░░░░░░░
░░░░▄█░░░░░░░░░░░░▀▀▄▄░▓▓▓░░░░░░░
░░░▄█░░░░░░░░░░░░░░░░░▀▓▓▓▓▀▀▀█░░
▀▄▄█░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓░░█░░
▀▄█░▀▄░░░░▄▄░░░░░░▓▓▓▓▓▓▓░░▓▓▓▓▓▓
▄▀█▀▄░░░░███░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓░
░▀█▀▄░░░░▀▀░░░░░░░░░▄▄░░░▓▓▓▓▓░░░
░░▀█░░░░░░░░▄▄░░░░░███░░░░▓▓░█░░░
░░░▀█░░░░░░█░░▀▄░░░▀▀░░░░░▓░█▀░░░
░░░░▀█░░░░░░▀▄▄▀░░░░░░░░▀▄░█▀░░░░
░░░░░░▀█▄░░░░░░░░░░░░░▀▄░░██░░░░░
░░░░░░░░░▀█▄░░░░░░░░▀▄░░██▀░▀░░░░
░░░░░░░░░░░░▀▀▄▄▄▄▄▄▄█▀█░░▀▄░░░░░
░░░░░░░░░░░░░░░░░░░░░░░░▀░░░░░░░░".pink
end

def squidward
  puts `clear`
  puts "M+~~~~~~~~+=~~=D.
        .M=~~~$+~~~~~~~~~~~~~~~O.
     :Z~~~~~~~~~~~~~~~~~~~~~~~~~~.
   O7Z~~~~~+~~~~~~~$Z+~~~~~ZZ~~~~~D.
 M:~~~~~~~Z$~~~~~~~~~~~~~~~~~~~~~~~M
D~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~O
~~~~+?~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
7Z~~~+Z~~~~~~~$D?~~~~~~~~~~~~~~~~~~~~~~~~?
M~~~~~~~~~~M~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~M                                                  ..M~?
:~~~~~~~~:Z~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~M.                                        .. +NM7,~~~~~=
~~~~~~~~7~~~~~:M=~~~~~~~~~~~~~~~~~~~~~~~~~~M                                    D=~~~~~~~~~~~~~~~~?
D~~=Z+~~,~~~~$=~~~~~~~~~:NO~~~~~~~~~~~~~~~~~.                                  ~~~~~~~~~~~~~~~~~~++.
=~~=~~~~~~~+~~~~~~~:ZI~~~~~~~~~~~~~~~~~~~~~I.                                M~~~~~~~~~~~~~~~~~++N.
~~~~~~~~~~M~~~~~~Z~~~~~~~~~~~~~~~~~~~~~~~~~                                 M~~~~~~~~~~~~~~~==++D
Z~~~~~~~~M~~~~~I:~~~~~Z,:::::,~~~~~~~~~~~~+                               .,:~~~~~~~~~~~++?$7Z?
~~~~~~~~~~~~~M~~~~~~~M:::::::::~~~~~~~~~~7                                ~=~~~~~~~~=++++77NO.
=~$Z~~~~~~~~~~~~~~~~~:::::::::::8~~~~~~~=                             .N~~~~~~~~~~~=++ODND.
M~7?~~~~~~~=~~~~~~~:~::::::::::::M~~~~+I                           ..N~~~~~~~~~~~~+++IM
~~~~~~~~~Z~~~=,,:::MM::::8D::::::M~~~~7   .7MD,.                 =,~~~~~~~~~7:. ...
M~~~~~~~~~~~=::::::::+:::88I::::::~~~~=7~~~~~~~~M              M~~~~~~~~~Z
I~~~~~~~~~~M:::::::::~::I88Z:::::M~~~~~~~~:ZMN:~N          ~=~~~~~~~~M.
7~~~~~~~~~$:::::::::~:::7O88::::$~~~~~D=~~~~~~~~?M+..  .M~~~~~~~~M.
I:~~~~~~~~:::~88:::::~:::887:::I~~~D~~~~~~~~~~~~~~~~~~:?~~~~+$..
=$~~~~~~M:::888:::+~D:::::::Z~~M~~~~~~~~~~~~~~~~~~~~~M~+$.
        M:::888I~$~~~~~8$~~~M~~~~~~~=====~~~~~~~~~=N?
         7:::O888~~~~~~~M~7~~~~~~==++++$777M++?MD8.
           ,:::8,~~~~~~~::~~~~~M MZ77M+7D8M++=8
            IOI?N~~~~~~?~~~~~~Z8 .D7$$ZZ$77$77=
          .Z~~~~~~~~~M~~~~~~?M777D777777777777.
          $~~~~~~Z~I=:~~~~~N~~~M77D7777777778.
         ?~~~~:?~?Z~~~~~~~?~~~~~M77$7777Z8
         8~~~N~~$~~~~~~~I~~~~~~~~78$77O..
         M~~7~~O~~~~~~~D~~~~~~~~~$777777N.
          :~~~=~~~~~~~M~~~~~~~~~~77777777D.
           ..~~~~~~~~M~~~~~~~~~~N7777777778.
           .~~~~~~~~M$=~~~~~~:I777777777777M
           M~~~~~~~7777$I8MM..77777777777777$
           =~~~~~~87777$O,    .77777777777777.
          .O:~~+8$777O=..      $7777777777777D
           .88$OMZ.            D77777777777777
                               N77777777777777M
                               $77777777777777Z.
                              .7777777777777777.
                              M7777777777777777I
                             .$7777777777777777M
                             O77777$ONMMD$$7777M
                            O$77Z~~~~~~~~~~~~M$Z
                             M~~~~~~~~~~~~~~~~=.
                             ?~~~~~~~~~~~~~~~~M
                            M~~~~~~~~~~~~~~~~~
                           .~~~~~~~~~~~~~~~~~=
                          .,~~~+,:~~~~O~~~~=~.
                          M~~~M~~~==?.I~~=~~~.
                         =:::?~:::,.  ,,.....".blue
                       end




def greeting
  hello_kitty
  prompt = TTY::Prompt.new.select("Welcome to Heard From a Friend.".pink) do |y|
    y.choices "Sign in" => "existing", "New Member" => "signup", Exit: "exit"
  end

  case prompt

  when "existing"
    existing

  when "signup"
    signup

  when "exit"
    squidward
    puts "Enjoy your day!".blue
    exit
  end
  puts 'clear'
end

def signup
  puts "Please enter an Email Address".light_blue
  email_address = gets.strip.downcase
  if email_address == "exit"
    puts "Thank you for using Heard From a Friend, have a nice day.".red
    exit
  end
  if EmailAddress.valid?(email_address) != true
    puts "That was an invalid email address format,please try again".green
    signup
  elsif User.find_by(email: email_address) != nil
    i = TTY::Prompt.new.select("Sorry, that email address is already in use with another account. Would you like to:") do |y|
      y.choices "Sign in with existing account?": "existing", "Make a new account?" => "signup", Exit: "exit"
    end

      case i
      when "existing"
        existing
      when "signup"
        signup
      when "exit"
        puts "Thank you for using, have a nice day.".green
        exit
      end
  else
    puts "Please enter your full name".blue
    name = gets.strip.downcase
      if name == "exit"
        puts "Thank you for using Heard From a Friend, have a nice day.".pink
        exit
        
      end

    new_user = User.create(name:name, email:email_address)
    main(new_user)
    puts 'clear'
    end
  end

  def existing

    puts "Please enter your email address".yellow
    email_address = gets.strip.downcase
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
          puts "Thank you for using, have a nice day.".green
          exit
        end
    else
      user = User.find_by(email:email_address)
      main(user)
    end
    gets 'clear'
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
      puts "Thank you for using Heard From a Friend, have a nice day.".pink
      exit
    when "update"
      update(user)
    end
    puts 'clear'
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
        when "exit"
        puts "Thanks for using! Have a great day."
        exit
      end
    else
    g = all.each_with_index { |act, i| results.push(puts " #{i + 1}. Place: #{act.place},  Price :#{act.price},  Genre:#{act.genre}")}
    #binding.pry
    t = TTY::Prompt.new.select("Do you want to delete anything from your activity list?") do |y|
      y.choices "Yes" => "Yes", "No" => "No"
    end
    case t
    when "Yes"
          delete(user)
    when "No"
        i = TTY::Prompt.new.select("Would you like to:") do |y|
        y.choices "Go back to your saved activites?" => "saved_activities", "Search for new activities?" => "search", "Exit?" => "exit"
        end
          case i
          when "saved_activities"
            saved_activities(user)
          when "search"
            add(user)
          when "exit"
            puts "Thank you so much for using Heard from a Friend. Have a nice day!"
            exit
          end
        end
      end
      puts 'clear'
      end

  def delete(user)
    # user.reload
    sa = SavedActivity.where(user_id: user.id)
    prompt = TTY::Prompt.new
    options = []
    sa.each {|act| options.push({name:"Place: #{act.activity.place}, Price: $#{act.activity.price}, Genre: #{act.activity.genre}", value: act})}
    var = prompt.select("You choose to delete", options)


    i = TTY::Prompt.new.select("Are you sure you want to delete this activity?") do |y|
      y.choices Yes: "yes", No: "no"
    end
    case i
    when "yes"

       SavedActivity.destroy(var.id)

      user.reload
      saved_activities(user)

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
        new_email = gets.strip.downcase
        if EmailAddress.valid?(new_email) != true
          puts "That was an invalid email address format, please try again."
          update(user)
        elsif User.find_by(email:new_email)
            i = TTY::Prompt.new.select("Sorry, there's already an email account with that address.") do |y|
              y.choices "Try again?" => "existing", "Go to the main page" => "main", Exit: "exit"
            end

              case i
              when "existing"
                update(user)
              when "main"
                main(user)
              when "exit"
                puts "Thank you for using, have a nice day.".green
                exit
              end
        else
          user.update(email: new_email)
          puts "Email updated!"
          update(user)
        end
    when "name"
      puts "What would you like to change your name to?"
        new_name = gets.strip.downcase
        user.update(name: new_name)
        puts "Name updated!"
          update(user)
    when "delete"
      t = TTY::Prompt.new.select("You sure you want to delete your profile?") do |y|
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

    puts "How much would you like to spend? To go back type exit."
    number = gets.chomp.downcase
    const = "abcdefghijklmnopqrstuvwxyz ',/'][=-`~#!@{'%^&*()_+|}{;:',?/'/"


    if number == "exit"
         add(user)
    elsif number.chars.any? {|char| const.include?(char)}
      puts "Please type in a number. To exit, type exit."
        find_by_response(name, user)
    else
      puts `clear`
      selected_act = Activity.select{|info|info.name == name && info.price <= number.to_i}
      if selected_act.length == 0
        t = TTY::Prompt.new.select("Sorry, there was nothing in that price range. Want you like to:") do |y|
          y.choices "Try again?" => "Yes", "Choose a different kind of activity?" => "No", "Go back to the main page" => "main", Exit: "exit"
        end

        case t
        when  "Yes"
          find_by_response(name, user)
        when "No"
          add(user)
        when "main"
          main(user)
        when "exit"
          puts "Thanks for using! Hope to see you again soon."
          exit
        end
  else
    prompt = TTY::Prompt.new
    options = []
    selected_act.each {|act| options.push({name: "Place: #{act.place}, Price: $#{act.price}, Type: #{act.genre}, Best Time to Go: #{act.best_time}", value: act})}
    var = prompt.select("Here are your options:", options)

    puts `clear`
    v = SavedActivity.create(user_id:user.id, activity_id:var.id)

    user.reload

    i = TTY::Prompt.new.select("Activity saved in your profile! Do you want to:") do |y|
      y.choices "Look for more events?" => "events", "See saved activities?" => "saved_events", "Log out?" => "main", Exit: "exit"
    end

        case i
        when "events"
          add(user)
        when "saved_events"
          saved_activities(user)
        when "main"
          main(user)
        when "exit"
          puts "Come back soon!"
          exit
        end
      end
    end
  end





greeting
