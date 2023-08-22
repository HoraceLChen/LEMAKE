class Meal < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :ingredients, through: :uploaded_ingredients
end
