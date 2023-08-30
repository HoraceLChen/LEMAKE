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
    ingredient = Ingredient.find_by(id: params[:ingredient][:id])
    pantry_ingredient = current_user.pantry_ingredients.find_by(ingredient: ingredient)
    if pantry_ingredient.nil?
      pantry_ingredient = PantryIngredient.new
      pantry_ingredient.ingredient = ingredient
      pantry_ingredient.user = current_user
      pantry_ingredient.save
      head :created
    else
      pantry_ingredient.destroy
      head :ok
    end
  end
end
