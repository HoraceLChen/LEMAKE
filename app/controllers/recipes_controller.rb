class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]
  def index
    @meal = Meal.find(params[:meal_id])

    combined_ingredients_ids = current_user.uploaded_ingredients.pluck(:ingredient_id) |
                               current_user.pantry_ingredients.pluck(:ingredient_id)

    combined_ingredients = Ingredient.where(id: combined_ingredients_ids).pluck(:name)

    time = @meal.time_preference
    people = @meal.people_preference

    service = ChefgptService.new(combined_ingredients, time, people)

    # create method to check if combined_ingredients match with any previously saved recipe. if it does, return that recipes steps, image etc.

    # SQL Query with combined ingredients array

    #Indexing
    # use a GIN (Generalized Inverted Index) to index popular ingredients. could seed the popular list on heroku
    #Caching

    #Asynch processing using Sidekiq or Active Job
    # run the query as soon as they put in their ingredients.

    #batch querying?

    @recipes = service.generate_recipes

    # if @recipes&.any?
    #   @recipes
    # else
    #   render template: 'uploaded_ingredients/index'
    # end
  end

  def search
    # ... (your existing search method code, if any)
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
