class ReviewsController < ApplicationController
  def create
    review = Review.new(review_params)
    review.user = current_user
    if review.save
      recipe = Meal.find(params[:meal_id]).recipe
      redirect_to meal_recipe_path(params[:meal_id], recipe)
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :meal_id)
  end
end
