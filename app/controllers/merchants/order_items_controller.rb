class Merchants::OrderItemsController < ApplicationController

  def update
    orderItem = OrderItem.find(params[:id])
    item = Item.find_by(id: orderItem.item_id)
    order = Order.find_by(id: orderItem.order_id)
    if item.inventory >= orderItem.order_quantity
      item.inventory = item.inventory - orderItem.order_quantity
      item.save
      orderItem.fulfilled = true
      orderItem.save
        if order.order_items.all? { |order_item| order_item.fulfilled == true }
          order.status = "packaged"
          order.save
        end
      flash[:success] = "You have successfully fulfilled this order"
      redirect_to dashboard_order_path(orderItem.order_id)
    else
      flash[:failure] = "You do not enough inventory to fulfilled this order"
      flash[:success] = "You have successfully fulfilled this order"
      redirect_to dashboard_order_path(orderItem.order_id)
    else
      flash[:failure] = "You do not have enough inventory to fulfilled this order"
      redirect_to dashboard_order_path(orderItem.order_id)
    end
  end

end
