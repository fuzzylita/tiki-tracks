class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thanks for joining Tiki-Tiki, #{@user.username}!"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = current_user
    # TODO: the below check needs to be included in the drinks controller
    if @user.id == params[:id].to_i
      render :show
    else
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
