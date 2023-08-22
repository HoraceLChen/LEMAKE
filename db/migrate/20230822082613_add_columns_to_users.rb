class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :favoritor_score, :text
    add_column :users, :favoritor_total, :text
  end
end
