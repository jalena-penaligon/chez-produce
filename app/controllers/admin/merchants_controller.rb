class Admin::MerchantsController < ApplicationController

  before_action :current_admin

  def show
    @merchant = User.find(params[:id])
    if @merchant.role != 'merchant'
      redirect_to admin_user_path(params[:id])
    end
  end
end
