class AddIngsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :ings, :string, array: true, default: []
  end
end
