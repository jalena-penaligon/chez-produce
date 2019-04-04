class Admin::UsersController < ApplicationController
  def show
    @admin = current_admin
  end
end
