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
  
  def create_facebook
    user = User.find_or_create_by(email: auth['info']['email']) do |u|
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      # setting password to a 32 char random string, since user
      # does not manually set or need the password for oauth
      u.password = SecureRandom.hex
    end
    session[:user_id] = user.id
    
    redirect_to user_path(user.id)
  end

  def destroy
    session.clear
    redirect_to root_path
  end
  private
  
   def auth
     request.env['omniauth.auth']
   end
end