class PantryIngredientsController < ApplicationController
  def index
    @pantry_ingredients = current_user.pantry_ingredients
    @pantry_ingredient = PantryIngredient.new
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
  end

  # might not have create anymore but a search bar instead
  # def create
  #   raise
  #   @ingredient = Ingredient.find_or_create_by(name: ingredient_params[:name].downcase)
  #   @pantry_ingredient = PantryIngredient.new
  #   @pantry_ingredient.ingredient = @ingredient
  #   @pantry_ingredient.user = current_user
  #   if @uploaded_ingredient.save
  #     redirect_to pantry_user_path(current_user)
  #   else
  #     # Handle unsuccessful save, e.g., re-render the form with errors or show an error message
  #     @pantry_ingredients = current_user.pantry_ingredients
  #     @pantry_ingredient = PantryIngredient.new
  #     @ingredient = Ingredient.new
  #     @ingredients = Ingredient.all
  #     render :index, status: :unprocessable_entity
  #   end
  end
end
