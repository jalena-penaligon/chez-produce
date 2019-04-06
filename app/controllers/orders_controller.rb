class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: params[:profile_id])
  end

  def show

  end

end
