class AddDateToLunches < ActiveRecord::Migration[5.2]
  def change
    add_column :lunches, :date, :string 
  end
end
