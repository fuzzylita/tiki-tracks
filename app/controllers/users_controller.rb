class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :create_facebook]  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      complete_login
    else
      render :new
    end
  end

  def create_facebook
    @user = User.find_or_create_by(email: auth['info']['email']) do |u|
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      # setting password to a 32 char random string, since user
      # does not manually set or need the password for oauth
      u.password = SecureRandom.hex
    end
    complete_login
  end

  def show
    @user = current_user
    if @user.id == params[:id].to_i
      render :show
    else
      redirect_to user_path(@user)
    end
  end

  private
  def complete_login
    session[:user_id] = @user.id
    flash[:success] = "Welcome to TikiTIki, #{@user.username}!"    
    redirect_to user_path(@user)
  end

  def auth
    request.env['omniauth.auth']
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
