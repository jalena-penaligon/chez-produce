class CartsController < ApplicationController
  def show
    if current_admin || current_merchant
      render_not_found
    end
  end
end
