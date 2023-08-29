class PantryIngredientsController < ApplicationController
  def index
    @pantry_ingredients = current_user.pantry_ingredients
    @pantry_ingredient = PantryIngredient.new
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
    @lol = []

    @ingredients_by_category = Ingredient.all.group_by(&:category)
    @user_ingredient_ids = current_user.pantry_ingredients.pluck(:ingredient_id)

    if params[:q].present?
      @lol = Ingredient.raw_search(params[:q])["hits"]
    end
  end

  def create
    if params[:ingredient_name].present?
      pantry_ingredient = PantryIngredient.new
      ingredient = Ingredient.find_by(name: params[:ingredient_name])
      pantry_ingredient.ingredient = ingredient
      pantry_ingredient.user = current_user
      pantry_ingredient.save
      redirect_to pantry_user_path
    else
      params[:selected_ingredients].each do |ingredient|
        PantryIngredient.find_or_create_by(ingredient: Ingredient.find(ingredient), user: current_user)
      end
      redirect_to pantry_user_path
    end
  end
end
