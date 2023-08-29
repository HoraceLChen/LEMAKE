class AddCategoryToIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :category, :string
  end
end
