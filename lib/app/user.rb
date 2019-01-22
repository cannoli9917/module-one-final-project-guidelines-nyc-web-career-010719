class User < ActiveRecord::Base
  has_many :lunches
  has_many :food_suggestions, through: :lunches




# be able to say their name
# be able to where they are (being as flatiron only)
# be able to get a suggestion for where they should go for lunch


end
