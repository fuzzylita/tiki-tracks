class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  helper_method :current_user, :logged_in?, :require_login
  
  before_action :require_login
  skip_before_action :require_login, only: [:index]

  def index
  end

  private

  def record_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def require_login
    redirect_to root_path unless logged_in?
  end

end
