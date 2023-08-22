class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    @recipes = Recipe.limit(3) #recipes comes from API
  end

  def show
  end

  private

  def set_recipe
    @recipe = recipe.find(params[:id])
  end
end
