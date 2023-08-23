class AddColumnsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :favoritable_score, :text
    add_column :recipes, :favoritable_total, :text
  end
end
