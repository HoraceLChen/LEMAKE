class MealsController < ApplicationController
  before_action :set_meal, only: [:edit, :update]

  def index
  end

  def new
    @meal = Meal.new # links to camera outside app
  end

  def create
    @meal = Meal.new(meal_params) #=> google lends comes here?
    @meal.user_id = cerrent_user.id
    if @meal.save
      redirect_to uploaded_ingredients_index_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @meal.update(meal_params) # => not updating
    redirect_to meal_recipes_path(@meal)
  end

  private

  def meal_params
    params.require(:meal).permit(:user_id, :img)
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end
end
