class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    api_key = ENV['SPOONACULAR_API_KEY']
    service = SpoonacularService.new(api_key)

    ingredients = params[:ingredients].split(',') # Assuming you're passing ingredients as a comma-separated list
    @recipes = service.search_by_ingredients(ingredients)

    if @recipes
      @recipes = Recipe.limit(3) #This comes from API
    else
      render template: 'uploaded_ingredients/index'

    end
  end

  def search

  end
  def show
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
