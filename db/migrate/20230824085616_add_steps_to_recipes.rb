class AddStepsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :steps, :string, array: true, default: []
  end
end
