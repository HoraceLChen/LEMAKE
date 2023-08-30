class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  # def index
  #   @fixed_recipe = Recipe.first
  #   api_key = ENV['SPOONACULAR_API_KEY']
  #   service = SpoonacularService.new(api_key)
  #   @meal = Meal.find(params[:meal_id])
  #   ingredients = @meal.ingredients.map { |ingredient| ingredient.name } # Assuming you're passing ingredients as a comma-separated list
  #   uploaded_ingredients = current_user.uploaded_ingredients.pluck(:ingredient_id)
  #   pantry_ingredients = current_user.pantry_ingredients.pluck(:ingredient_id)
  #   combined_ingredients_ids = uploaded_ingredients | pantry_ingredients
  #   combined_ingredients = Ingredient.where(id: combined_ingredients_ids).pluck(:name)
  #   @recipes = service.search_by_ingredients(combined_ingredients)
  #   raise
  #   # raise
  #   if @recipes
  #     @recipes
  #   else
  #     render template: 'uploaded_ingredients/index'

  #   end
  # end

  def index
    @fixed_recipe = Recipe.first
    @meal = Meal.find(params[:meal_id])

    # Get uploaded ingredient IDs from the current user and fetch their names
    uploaded_ingredients_ids = current_user.uploaded_ingredients.pluck(:ingredient_id)
    uploaded_ingredients = Ingredient.where(id: uploaded_ingredients_ids).pluck(:name)

    # Get pantry ingredient IDs from the current user and fetch their names
    pantry_ingredients_ids = current_user.pantry_ingredients.pluck(:ingredient_id)
    pantry_ingredients = Ingredient.where(id: pantry_ingredients_ids).pluck(:name)

    # Time and number of people can be obtained either from parameters or other sources
    time = @meal.time_preference
    people = @meal.people_preference

    # Use the RecipeService to generate recipes based on the combined ingredients, time, and people
    service = ChefgptService.new(uploaded_ingredients, pantry_ingredients, time, people)
    @recipes = service.generate_recipes
    if @recipes && @recipes.any?
      @recipes  # Use @recipes in your view to display the generated recipes
    else
      render template: 'uploaded_ingredients/index'
    end
  end

  def search

  end

  def show
    @review = Review.new
    @meal = Meal.find(params[:meal_id])
    # api_key = ENV['SPOONACULAR_API_KEY']
    # recipe = @meal.recipe.spoonacular_id
    # service = SpoonacularServiceRecipe.new(api_key, recipe)
    # @recipes = service.search_by_recipe(recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
