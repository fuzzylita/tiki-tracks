class IngredientsController < ApplicationController
  def index
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.find_or_create_by(name: ingredient_params[:name])
    if @ingredient.save
      redirect_to new_user_drink_path(current_user)
    else
      render :'drink/new'
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
