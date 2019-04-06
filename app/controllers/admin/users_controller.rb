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
    else
      render_not_found
    end
  end
end
