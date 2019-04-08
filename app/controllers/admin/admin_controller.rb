class Admin::AdminController < ApplicationController

  def show
    if current_admin
      @orders = Order.sort_by_status
    else
      render_not_found
    end
  end
end
