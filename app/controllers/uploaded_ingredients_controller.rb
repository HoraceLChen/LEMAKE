class UploadedIngredientsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_uploaded_ingredien, only: [:edit, :update]

  def index
    @uploaded_ingredients = Uploaded_ingredients.all
  end

  def create
    @uploaded_ingredient = Uploaded_ingredient.new(uploaded_ingredient_params)
    @uploaded_ingredient.user_id = cerrent_user.id
    if @uploaded_ingredient.save
      redirect_to edit_meal_uploaded_ingredient_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @uploaded_ingredient.update(uploaded_ingredient_params)
    redirect_to edit_meal_path(@uploaded_ingredient)
  end

  private

  def uploaded_ingredient_params
    params.require("uploaded_ingredient").permit(:meal_id, :ingredient_id)
  end

  def set_uploaded_ingredient
    @uploaded_ingredient = Uploaded_ingredient.find(params[:id])
  end
end
