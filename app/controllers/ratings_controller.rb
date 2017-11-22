class RatingsController < ApplicationController
  # TODO - require login

  def create
    rating = Rating.find_or_create_by(
      user_id: rating_params[:user_id].to_i,
      drink_id: rating_params[:drink_id].to_i
    )

    rating.rating = rating_params[:rating].to_i

    if rating.save
      drink = Drink.find(rating_params[:drink_id])
      if rating_params[:user_id] == drink.user.id
        redirect_to user_drink_path(drink.user.id, drink.id)
      else
        redirect_to drink_path(drink.id)
      end
    else
      redirect_to :back, error: "Problem saving the rating. Please try again."
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :user_id, :drink_id)
  end
end
