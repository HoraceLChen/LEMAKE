class Ingredient < ApplicationRecord
  # app/models/ingredient.rb
  CATEGORIES = [
    "Baking", "Canned and Jarred", "Cheese", "Condiments", "Meat", "Milk, Eggs, Other Dairy",
    "Nuts", "Oil, Vinegar, Salad Dressing", "Produce", "Seafood", "Spices and Seasonings",
    "Sweeteners (Nut butters, Jams, and Honey)", "Pantry Essentials", "Beverages",
    "Specialty Foods", "Snacks", "Miscellaneous", "Cold/Frozen Items"
  ]

  validates :category, inclusion: { in: CATEGORIES }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
