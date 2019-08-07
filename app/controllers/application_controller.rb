class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in? #makes these methods available to views

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # return current user (if it's already been found in the database) OR make user available if the user is logged in
  end

  def logged_in?
    !!current_user #converts to boolean, will return true if logged in
  end

  def require_user
    if !logged_in?
      flash[:notice] = "You must be logged in first"
      redirect_to login_path
    end
  end
end
