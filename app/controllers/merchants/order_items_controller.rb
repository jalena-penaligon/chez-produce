class Merchants::OrderItemsController < ApplicationController

  def update
    orderItem = OrderItem.find(params[:id])
    item = Item.find_by(id: orderItem.item_id)
    if item.inventory >= orderItem.order_quantity
      item.inventory = item.inventory - orderItem.order_quantity
      item.save
      orderItem.fulfilled = true
      orderItem.save
      flash[:success] = "You have successfully fulfilled this order"
      redirect_to dashboard_order_path(orderItem.order_id)
    else
      flash[:failure] = "You do not have enough inventory to fulfilled this order"
      redirect_to dashboard_order_path(orderItem.order_id)
    end
  end

end
