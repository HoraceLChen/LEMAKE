class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :meals
  has_many :reviews, through: :meals
  acts_as_favoritable
end
