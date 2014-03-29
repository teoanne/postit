class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in? # putting it here allows for it to be used not only throughout the controllers but also all the views

  def current_user
    @current_user ||=User.find(session[:user_id]) if session[:user_id] # memoization
  end

  def logged_in? # turns it into a boolean value
    !!current_user
  end

  def require_user # it is put here because it will be used throughout the application instead of just within certain controllers
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to root_path
    end
  end

 

end
