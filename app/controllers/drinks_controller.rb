class DrinksController < ApplicationController
  before_action :valid_user
  skip_before_action :valid_user, only: [:all, :public]

  # * PUBLIC VIEW *

  def all
    @drinks = Drink.all
  end
  
  def public
    @drink = Drink.find(params[:id])
  end

  # * USER VIEW *

  def index
    user = User.find_by(id: params[:user_id])
    @drinks = user.drinks
  end

  def new
    @drink = Drink.new
  end

  def create
    @drink = current_user.drinks.build(drink_params)
    if @drink.save
      redirect_to user_drink_path(current_user, @drink)
    else
      render :new
    end
  end

  def show
    @drink = Drink.find(params[:id])
  end

  def edit
    @drink = Drink.find(params[:id])
  end

  def update
    @drink = Drink.find(params[:id])
    @drink.update(drink_params)
    redirect_to user_drink_path(current_user, @drink)
  end

  def destroy
    drink = Drink.find_by(params[:id])
    if drink
      drink.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_drinks_path(current_user), alert: "Drink Not Found"
    end
  end

  private

  def valid_user
    redirect_to user_path(current_user), alert: "You are not authorized to view this page!" unless current_user.id == params[:user_id].to_i
  end

  def drink_params
    params.require(:drink).permit(:name, :instructions, ingredients_attributes: [:name, :quantity])
  end
end
