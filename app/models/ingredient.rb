class Ingredient < ApplicationRecord
  include AlgoliaSearch
  CATEGORIES = [
    "Baking", "Canned and Jarred", "Cheese", "Condiments", "Meat", "Milk, Eggs, Other Dairy",
    "Nuts", "Oil, Vinegar, Salad Dressing", "Produce", "Seafood", "Spices and Seasonings",
    "Sweeteners (Nut butters, Jams, and Honey)", "Pantry Essentials", "Beverages",
    "Specialty Foods", "Snacks", "Miscellaneous", "Cold/Frozen Items"
  ]

  algoliasearch do
    attributes :name
  end

  validates :category, inclusion: { in: CATEGORIES }
  validates :name, uniqueness: { scope: :category, case_sensitive: false, message: "should be unique within the same category" }
end
