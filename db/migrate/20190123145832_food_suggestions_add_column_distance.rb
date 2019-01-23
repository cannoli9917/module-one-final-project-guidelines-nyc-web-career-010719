class FoodSuggestionsAddColumnDistance < ActiveRecord::Migration[5.2]
  def change
    add_column :food_suggestions, :distance, :string 
  end
end
