class User < ActiveRecord::Base
  has_many :lunches
  has_many :food_suggestions, through: :lunches


end
