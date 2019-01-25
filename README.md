

LUNCH BREAK README


DESCRIPTION
Welcome to Lunch Break! Wondering where to get lunch today? Let this simple command-line interface application check the weather and give you a tailored lunch break suggestion for the day. Keep a list of favorite places and view your lunch history. Delete your account and we won't store your name data anymore.

Currently this app functions for the Flatiron School Financial District NYC location.

For this application we used the Dark Sky API to check weather and suggest a lunch spot from three tiers of distance from start location (Flatiron School).  Locations in the building, nearby and in the neighborhood are determined as favorable distances based on temperature and chance of precipitation.

in the building: Less than 30°F or > 0.7 chance of precipitation
nearby: Between 30°F and 50°F or between 0.3 and 0.7 chance of precipiation
in the neighborhood: Greater than 50°F and < 0.3 chance of precipitation

We used models to illustrate classes of user, food suggestion and lunch with lunch being the join table that stores all of the information about a specific lunch event.  Date is also stored and a lunch history can be viewed with date and place.

Domain model:
User has_many FoodSuggestion through: Lunch
FoodSuggestion has_many User through: Lunch
Lunch belongs_to: User
Lunch belongs_to: FoodSuggestion

INSTRUCTIONS

1) clone this repository to your local machine and go to the file in your terminal
2) run bundle install
3) run rake db:seed to populate your SQL database with the lunch places provided in seeds.rb
4) run ruby bin/run.rb
5) follow along in your terminal to be given lunch suggestions and use other functionality
6) enjoy your lunch!


CONTRIBUTORS GUIDE

1) fork this repository
2) create a feature branch-- run git checkout -b my-branch-name
3) commit your changes-- run git commit -am 'Adding this feature'
4) push to the branch-- run git push origin my-branch-name
5) submit a pull request


LICENSES

Katie Pennachio
Emily Seieroe
January 25, 2019


Powered by Dark Sky
https://darksky.net/poweredby/
