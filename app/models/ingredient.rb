class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
