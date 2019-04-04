class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thanks for registering, you are now logged in!"
      redirect_to profile_path
    else
      render :new
    end
  end

  def index

  end

  def show
    @user = User.current_user
  end

  def edit

  end

  private
  def user_params
    params.require(:user).permit(:name, :street_address, :city, :state, :zipcode, :email, :password, :password_confirmation)
  end
end
