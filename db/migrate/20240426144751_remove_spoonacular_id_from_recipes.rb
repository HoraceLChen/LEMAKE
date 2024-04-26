class RemoveSpoonacularIdFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :spoonacular_id, :string
  end
end
