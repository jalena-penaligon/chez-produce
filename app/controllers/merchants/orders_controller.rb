class Merchants::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

end
