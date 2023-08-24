class MealsController < ApplicationController
  before_action :set_meal, only: [:edit, :update]

  def index
  end

  def new
    @meal = Meal.new
    # new_uploaded_ingredient
  end

  def create
    @meal = Meal.new(meal_params)
    # new_uploaded_ingredient
    @meal.user = current_user
    if @meal.save
      redirect_to uploaded_ingredients_index_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def favourite_toggle
    recipe = Recipe.find(params[:recipe])
    current_user.favorited?(recipe) ? current_user.unfavorite(recipe) : current_user.favorite(recipe)
    p current_user.all_favorites
    head :ok
  end

  def update
    @meal.update!(meal_params)
    redirect_to meal_recipes_path(@meal)
  end

  private

  def meal_params
    params.require(:meal).permit(:user_id, :img, :time_preference, :people_preference, :cuisine_preference)
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end

#   def new_uploaded_ingredient
#     @uploaded_ingredient = UploadedIngredient.new
#   end
end
