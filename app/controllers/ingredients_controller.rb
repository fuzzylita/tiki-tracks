class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.order('LOWER(name)')
    respond_to do |format|
      format.html
      format.json { render json: @ingredients}
    end
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.find_or_create_by(name: ingredient_params[:name])
    if @ingredient.save
      redirect_to ingredients_path
    else
      render :'drink/new'
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
