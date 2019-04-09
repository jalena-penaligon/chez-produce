class Admin::UsersController < ApplicationController

  def index
    if current_admin
      @users = User.all_users
    else
      render_not_found
    end
  end

  def show
    if current_admin
      @admin = current_user
      @user = User.find(params[:id])
    else
      render_not_found
    end
  end

  def upgrade
    if current_admin
      user = User.find(params[:id])
      user.role = 'merchant'
      user.save
      flash[:notice] = "User has been upgraded."
      redirect_to admin_merchant_path(user)
    else
      render_not_found
    end
  end
end
