class Merchants::OrdersController < ApplicationController

  def show
    @merchant = current_user
    @order = Order.find(params[:id])
  end

end
