class MerchantsController < ApplicationController

  def index
    @merchants = User.active_merchants
    @top_by_revenue = User.top_merchants_by_revenue
    @top_by_fulfillment = User.merchants_by_fulfillment("ASC")
    @bottom_by_fulfillment = User.merchants_by_fulfillment("DESC")
    @top_states = User.top_states
    @top_cities = User.top_cities
    @top_orders = Order.top_orders
    if current_admin
      @merchants = User.all_merchants
    else
      @merchants = User.active_merchants
    end
  end

  def show
    if current_merchant
      @merchant = current_user
      @items_sold = Item.merchant_items_sold(5,'desc',current_user.id)
      @percent_sold = Item.percent_sold(current_user.id)
      @top_states = User.merchant_top_states(current_user.id)
      @top_cities = User.merchant_top_cities(current_user.id)
      @top_purchaser_by_orders = User.top_purchaser_by_orders(current_user.id)
      @top_purchaser_by_quantity = User.top_purchaser_by_quantity(current_user.id)
      @top_spenders = User.top_spenders(current_user.id)
    else
      render_not_found
    end
  end
end
