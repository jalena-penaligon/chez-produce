class ItemsController < ApplicationController
  def index
    @items = Item.active_items_by_merchant
  end
end
