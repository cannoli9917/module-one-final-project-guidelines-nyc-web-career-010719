class Lunch < ActiveRecord::Base
  belongs_to :user
  belongs_to :food_suggestion

  # be able to take in a user instance 
  # be able to take in a lunch suggestion instance
  # tells a user what to do for lunch
  #
end
