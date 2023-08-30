class BookmarksController < ApplicationController
  def index
    @recipes = Recipe.all
    @favorite_recipes = current_user.favorited_by_type('Recipe')
  end

  def open_recipe
    meal = Meal.new(user: current_user)
    meal.recipe = Recipe.find(params[:recipe])
    meal.save
    redirect_to meal_recipe_path(meal, meal.recipe)
  end
end
