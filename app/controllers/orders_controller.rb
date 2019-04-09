class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: params[:profile_id])
  end

  def show
    @order = Order.find(params[:id])
  end

  def ship
    order = Order.find(params[:id])
    order.update!(status: "shipped")
    # order.status =
    redirect_to admin_dashboard_path
  end

  def cancel
    @order = Order.find(params[:id])
    @order.status = 3
    @order.save
    redirect_to admin_dashboard_path
  end

end
