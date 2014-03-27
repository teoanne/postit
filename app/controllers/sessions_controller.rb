class SessionsController < ApplicationController

  def new
    user = User.new
  end

  def create
   user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in."
      redirect_to root_path
    else
      flash[:error] = "There is something wrong with your username or password."
      redirect_to register_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to root_path
  end

end