class ItemsController < ApplicationController
  def index
    @users = User.where(role: 2, active:true).entries
  end
end
