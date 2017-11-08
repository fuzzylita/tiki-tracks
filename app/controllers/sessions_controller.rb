class SessionsController < ApplicationController
  
  def new
  end

  def create
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