class CreateRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :serving
      t.references :ingredient, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
