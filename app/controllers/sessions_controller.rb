class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You're logged in!"
      redirect_to profile_path if user.role == "user"
      redirect_to dashboard_path if user.role == "merchant"
      redirect_to root_path if user.role == "admin"
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
