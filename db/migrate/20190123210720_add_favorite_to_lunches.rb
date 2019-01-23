class AddFavoriteToLunches < ActiveRecord::Migration[5.2]
  def change
    add_column :lunches, :is_favorite, :boolean
  end
end
