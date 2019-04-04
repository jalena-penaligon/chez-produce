class MerchantsController < ApplicationController

  def index
    @merchants = User.active_merchants
    @top_by_revenue = User.top_merchants_by_revenue
    @top_by_fulfillment = User.merchants_by_fulfillment("ASC")
    @bottom_by_fulfillment = User.merchants_by_fulfillment("DESC")
    @top_states = User.top_states
    @top_cities = User.top_cities
    @top_orders = Order.top_orders
  end

  def show
    @merchant = current_user
  end
end
