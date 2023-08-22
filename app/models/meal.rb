class Meal < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :ingredients, through: :uploaded_ingredients
  has_many_attached :photos
end
