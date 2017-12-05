class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.order('LOWER(name)')
    respond_to do |format|
      format.html
      format.json { render json: @ingredients }
    end
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    ingredient_params[:name].downcase!
    ingredient = Ingredient.find_by(name: ingredient_params[:name])
    if ingredient  
      render json: { messages: "Ingredient already exists, yo." }, status: :conflict
      return
    end

    ingredient = Ingredient.new(ingredient_params)
    if ingredient.save
      render json: ingredient
    else
      render json: { messages: ingredient.errors.messages }, status: :bad_request
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
