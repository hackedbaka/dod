class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    unless current_user
      flash["alert-warning"] = "You must be logged in to view that page"
      redirect_to new_session_path
    end
  end

  helper_method :admin?

  protected 

  def authorizeAdmin
    unless admin?
      flash[:error] = "unauthorized access"
      redirect_to home_session_path
      false
    end
  end

  def admin?
    if current_user && current_user.email == "portugalkevin@gmail.com" 
      return true 
    elsif current_user && current_user.email == "jeffrey.wu23@gmail.com"
      return true
    else
      return false
    end
  end

end

