class Review < ApplicationRecord
  belongs_to :meal
  has_one :user, through: :meal
end
