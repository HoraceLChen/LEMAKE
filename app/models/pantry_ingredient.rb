class PantryIngredient < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
end
