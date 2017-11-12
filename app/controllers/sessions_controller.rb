class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :create_facebook]
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to login_path, alert: "Invalid Email or Password"
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end