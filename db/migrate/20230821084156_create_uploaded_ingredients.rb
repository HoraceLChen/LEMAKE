class CreateUploadedIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :uploaded_ingredients do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
