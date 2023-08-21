class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.string :cuisine_preference
      t.string :img
      t.integer :time_preference
      t.integer :people_preference

      t.timestamps
    end
  end
end
