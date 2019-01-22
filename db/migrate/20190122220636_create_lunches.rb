class CreateLunches < ActiveRecord::Migration[5.2]
  def change
    create_table :lunches do |t|
      t.integer :user_id
      t.integer :food_suggestion_id
    end
  end
end
