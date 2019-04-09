class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: params[:profile_id])
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    order = Order.create(user_id: user.id, status: 0)
    order_items = order.generate_order_items(@cart)
    flash[:notice] = "Your order has been created!"
    session[:cart].clear
    redirect_to profile_orders_path(user)
  end

end
