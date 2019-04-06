class CartsController < ApplicationController
  def show
    if current_admin || current_merchant
      render_not_found
    elsif session[:cart] == nil
      flash[:notice] = "Your cart is empty."
    end
  end
end
