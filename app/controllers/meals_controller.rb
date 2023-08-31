class MealsController < ApplicationController
  before_action :set_meal, only: [:edit, :update, :upload_photo, :save_recipe]


  def index
    @recipe = Recipe.all.sample
    @pantry = current_user.pantry_ingredients
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

  def upload_photo
    recipe = @meal.recipe
    @meal.update!(meal_params)
    redirect_to meal_recipe_path(@meal, recipe)
  end

  def edit
  end

  def update
    @meal.update(meal_params)
    redirect_to meal_recipes_path(@meal)
  end

  def save_recipe
    recipe = Recipe.find(params[:recipe])
    @meal.recipe_id = recipe.id
    if @meal.save
      redirect_to meal_recipe_path(@meal, recipe)
    else
      render :index, status: :unprocessable_entity
    end
  end


  private

  def meal_params
    params.require(:meal).permit(:user_id, :photo, :time_preference, :people_preference, :cuisine_preference, :recipe_id)
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end

end
