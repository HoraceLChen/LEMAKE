class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    @recipes = Recipe.limit(3)
    @meal = Meal.find(params[:meal_id])
  end

  def show
    @meal = Meal.find(params[:meal_id])
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
