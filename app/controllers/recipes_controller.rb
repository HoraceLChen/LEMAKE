class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    api_key = ENV['SPOONACULAR_API_KEY']
    service = SpoonacularService.new(api_key)
    @meal = Meal.find(params[:meal_id])
    ingredients = @meal.ingredients.map { |ingredient| ingredient.name } # Assuming you're passing ingredients as a comma-separated list
    @recipes = service.search_by_ingredients(ingredients)
    # raise
    if @recipes
      @recipes
    else
      render template: 'uploaded_ingredients/index'

    end
  end

  def search

  end

  def show
    @review = Review.new
    @meal = Meal.find(params[:meal_id])
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
