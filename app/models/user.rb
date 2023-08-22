class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :meals
  has_many :recipes, through: :meals
  has_many :uploaded_ingredients, through: :meals
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  # add validation for @email.com to email field
  validates :password, presence: true, length: { minimum: 6 }
  acts_as_favoritor
end
