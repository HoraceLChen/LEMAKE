class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :image
      t.text :content
      t.string :cuisine
      t.integer :time
      t.integer :people

      t.timestamps
    end
  end
end
