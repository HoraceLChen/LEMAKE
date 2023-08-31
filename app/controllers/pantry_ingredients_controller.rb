class PantryIngredientsController < ApplicationController
  def index
    @pantry_ingredients = current_user.pantry_ingredients
    @pantry_ingredient = PantryIngredient.new
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
    pantry_essentials_raw = [
                              "Rice",
                              "Soy sauce",
                              "Sesame oil",
                              "Fish sauce",
                              "Mirin",
                              "Coconut milk",
                              "Oyster sauce",
                              "Chilli flakes",
                              "Five-Spice powder",
                              "Onion",
                              "Flour",
                              "Sugar",
                              "Rosemary",
                              "Olive oil",
                              "Canned tomatoes",
                              "Thyme",
                              "Chicken stock cubes",
                              "Pasta",
                              "Garlic powder",
                              "Paprika",
                              "Eggs",
                              "Milk",
                              "Bread",
                              "Butter"
                            ]

    @pantry_essentials = Ingredient.where(name: pantry_essentials_raw)

    @ingredients_by_category = Ingredient.all.group_by(&:category)
    @user_ingredient_ids = current_user.pantry_ingredients.pluck(:ingredient_id)

    if params[:q].present?
      @lol = Ingredient.raw_search(params[:q])["hits"]
    end
  end

  def create
    ingredient = Ingredient.find_by(id: params[:ingredient_id])
    pantry_ingredient = current_user.pantry_ingredients.find_by(ingredient: ingredient)
    if pantry_ingredient.nil?
      pantry_ingredient = PantryIngredient.new
      pantry_ingredient.ingredient = ingredient
      pantry_ingredient.user = current_user
      pantry_ingredient.save
      render json: { status: 'created', ingredient: ingredient}, status: :created
    else
      pantry_ingredient.destroy
      render json: { status: 'destroyed', ingredient: ingredient}, status: :ok
    end
  end
end
