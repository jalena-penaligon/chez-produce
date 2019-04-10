class ItemsController < ApplicationController
  def index
    @items = Item.active_items_by_merchant
    @most_popular = Item.items_sold(5, 'desc')
    @least_popular = Item.items_sold(5, 'asc')
  end

  def show
    @item = Item.find(params[:id])
    @fulfillment_time = OrderItem.fulfillment_time(@item)
  end

  def active_toggle
    item = Item.find(params[:id])
    if item.active?
      item.active = false
      item.save
      flash[:notice] = "The item is now disabled."
      redirect_to dashboard_items_path
    else 
      item.active = true
      item.save
      flash[:notice] = "The item is now enabled."
      redirect_to dashboard_items_path
    end
  end
end
