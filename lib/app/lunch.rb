class Lunch < ActiveRecord::Base
  belongs_to :user
  belongs_to :food_suggestion


  
end
