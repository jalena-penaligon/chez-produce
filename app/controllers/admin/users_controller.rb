class Admin::UsersController < ApplicationController
  def show
    if current_admin
      @admin = current_user
    else
      render_not_found
    end
  end
end
