class Admin::UsersController < ApplicationController
  def show
    @admin = current_user
  end
end
