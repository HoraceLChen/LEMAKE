class MealsController < ApplicationController
  before_action :set_meal, only: [:edit, :update]

  def index
    @recipe = Recipe.first
  end

  def create
    meal = Meal.create(user: current_user)
    redirect_to meal_uploaded_ingredients_path(meal)
    # if meal.save

    # end
  end

  def favourite_toggle
    recipe = Recipe.find(params[:recipe])
    current_user.favorited?(recipe) ? current_user.unfavorite(recipe) : current_user.favorite(recipe)
    p current_user.all_favorites
    head :ok
  end

  def edit
    @meal = Meal.new
  end

  def update
    @meal.update(meal_params)
    redirect_to meal_recipes_path(@meal)
  end

  private

  def meal_params
    params.require(:meal).permit(:user_id, :img, :time_preference, :people_preference, :cuisine_preference, :recipe_id)
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end

end
