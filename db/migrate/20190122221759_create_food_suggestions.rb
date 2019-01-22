class CreateFoodSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :food_suggestions do |t|
      t.string :suggestion
    end
  end
end
