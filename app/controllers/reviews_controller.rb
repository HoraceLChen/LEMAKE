class ReviewsController < ApplicationController
  def create
    review = Review.new(review_params)
    review.user = current_user
    recipe = Meal.find(params[:meal_id]).recipe
    if review.save
      redirect_to meal_recipe_path(params[:meal_id], recipe)
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :meal_id)
  end
end
