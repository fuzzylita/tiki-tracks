class RatingsController < ApplicationController
  
  def create
    rating = Rating.find_or_create_by(
      user_id: rating_params[:user_id].to_i,
      drink_id: rating_params[:drink_id].to_i
    )

    rating.rating = rating_params[:rating].to_f

    if rating.save
      drink = Drink.find(rating_params[:drink_id])
      render json: drink
    else
      render json: {messages: "Problem saving the rating. Please try again."}, status: :bad_request
    end
  end

  private

  def rating_params
    params.permit(:rating, :user_id, :drink_id)
  end
end
