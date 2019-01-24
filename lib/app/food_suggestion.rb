class FoodSuggestion < ActiveRecord::Base
  has_many :lunches
  has_many :users, through: :lunches



end
