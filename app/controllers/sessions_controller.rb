class SessionsController < ApplicationController
  def new
    if current_user != nil
      flash[:alert] = "You're already logged in!"
      if current_user.role == "admin"
        redirect_to root_path
      elsif current_user.role == "merchant"
        redirect_to dashboard_path
      elsif current_user.role == "user"
        redirect_to profile_path
      end
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.active == true
      session[:user_id] = user.id
      flash[:notice] = "You're logged in!"
      redirect_to profile_path if user.role == "user"
      redirect_to dashboard_path if user.role == "merchant"
      redirect_to root_path if user.role == "admin"
    else
      flash[:alert] = "Username or password does not match."
      render :new
    end
  end

  def destroy
    if session.clear
      flash[:notice] = "You're logged out!"
      redirect_to root_path
    else
      flash[:alert] = "Please try logging out again."
      redirect_to root_path
    end
  end
end
