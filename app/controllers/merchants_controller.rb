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
    else
      render_not_found
    end
  end
end
