 class DrinksController < ApplicationController
  before_action :find_drink, only: [:public, :show, :edit, :update, :destroy]
  before_action :unauthorized_drink, only: [:show, :edit, :update, :destroy]  
  before_action :unauthorized_user
  skip_before_action :unauthorized_user, only: [:all, :public, :proper]
  

  # * PUBLIC VIEW *

  def all
    @drinks = Drink.order_by_name
    respond_to do |format|
      format.html { render :all }
      format.json { render json: @drinks}
    end
  end
  
  def public
  end

  # * USER VIEW *

  def index
    user = User.find_by(id: params[:user_id])
    @drinks = user.drinks.order_by_name
  end

  def new
    @drink = Drink.new
    @drink.drink_ingredients.build
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
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @drink}
    end
  end

  def edit
  end

  def update
    @drink.update(drink_params)
    redirect_to user_drink_path(current_user, @drink)
  end

  def destroy
    if @drink
      @drink.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_drinks_path(current_user), alert: "Drink Not Found"
    end
  end

  def proper
    @drinks = Drink.proper_cocktails
  end

  private

  def find_drink
    @drink = Drink.find(params[:id])
  end

  def unauthorized_user
    redirect_to user_path(current_user), alert: "You are not authorized to view this page!" unless current_user.id == params[:user_id].to_i
  end

  def unauthorized_drink
    redirect_to user_path(current_user), alert: "You are not authorized to view this page!" if current_user.drinks.find_by(params[:id]).nil?
  end

  def drink_params
    params.require(:drink).permit(:name, :instructions, ingredients_attributes: [:id, :name, :quantity], ingredients: [:id, :name, :quantity])
  end
end
