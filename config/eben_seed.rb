#####################       Museums      #############################


gugg = Activity.create(name: "Museum", place: "Guggenhiem Museum", genre: "Rich People's Collections", price: 25, time:1400, date:["Monday", "Tuesday", "Friday", "Saturday"])
met = Activity.create(name: "Museum", place: "Metropolitan Museum", genre: "Encycolpedic Collection", price: 20, time: 1000, date:["Monday", "Thursday", "Friday", "Saturday", "Sunday"])
moma = Activity.create(name: "Museum", place: "Museum of Modern Art (MoMA)", genre: "Modern Art", price: 15, time: 1200, date:["Monday", "Wednesday", "Friday", "Saturday",])
momi = Activity.create(name: "Museum", place: "Museum of the Moving Image", genre: "Movie Museum", price: 5, time:1530, date:["Wednesday" "Thursday", "Friday", "Saturday"])
mofd = Activity.create(name: "Museum", place: "Museum of Food and Drink", genre: "Food and Drink Museum", price: 205, time:1645, date:["Monday", "Tuesday"])


#################            Park                  ###################

central_park = Activity.create(name: "Park", place: "Central Park", genre: "All Purpose Large Park", price: 0, time:1030, date:["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
mccarren = Activity.create(name: "Park", place: "McCarren Park", genre: "All Purpse Mid-sized Park", price: 5, time:1100, date:["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
b_b_park = Activity.create(name: "Park", place: "Brooklyn Bridge Park Pier 5", genre: "Large Sports Park", price: 0, time:1500, date:["Monday", "Tuesday"])
gramercy = Activity.create(name: "Park", place: "Gramercy Park", genre: "Private Park", price: 20, time:600, date:["Sunday", "Monday", "Tuesday", "Friday", "Saturday"])
prospect = Activity.create(name: "Park", place: "Prospect Park", genre: "All Purpose Large Park", price: 0, time: 1200, date:["Monday", "Tuesday", "Thursday", "Friday", "Saturday"])


##############            Public Events              ##################

lecture = Activity.create(name: "Public Event", place: "Prospect Park", genre: "Lecture on Biodiversity in NYC", price: 0, time: 1800, date:"Friday")
soccer = Activity.create(name: "Park", place: "Central Park", genre: "All are welcome Soccor game", price: 10, time: 1900, date:["Tuesday", "Thursday", "Saturday"])
