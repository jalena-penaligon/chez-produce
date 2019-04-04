class ItemsController < ApplicationController
  def index
    @items = Item.active_items_by_merchant
    @most_popular = Item.items_sold(5, 'desc')
    @least_popular = Item.items_sold(5, 'asc')
  end
end
