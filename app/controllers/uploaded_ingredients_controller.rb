class UploadedIngredientsController < ApplicationController
  before_action :set_meal, only: [:index, :create]

  def index
    @uploaded_ingredients = @meal.uploaded_ingredients
    @uploaded_ingredient = UploadedIngredient.new
    @ingredient_new = Ingredient.new
  end

  def create
    @ingredient = Ingredient.find_or_create_by(name: ingredient_params[:name].downcase)
    @uploaded_ingredient = UploadedIngredient.new
    @uploaded_ingredient.ingredient = @ingredient
    @uploaded_ingredient.meal = @meal
    if @uploaded_ingredient.save
      redirect_to meal_uploaded_ingredients_path(@meal)
    else
      # Handle unsuccessful save, e.g., re-render the form with errors or show an error message
      @uploaded_ingredients = @meal.uploaded_ingredients
      @ingredient_new = Ingredient.new
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @uploaded_ingredient = UploadedIngredient.find(params[:id])
    meal = @uploaded_ingredient.meal
    @uploaded_ingredient.destroy
    redirect_to meal_uploaded_ingredients_path(meal)
  end

  private

  def ingredient_params
    params.require(:uploaded_ingredient).require(:ingredient).permit(:name)
  end

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end
end
