class Recipe < ApplicationRecord
  has_many :ingredients, through: :recipe_ingredients
  acts_as_favoritable
end
