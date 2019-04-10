class Merchants::ItemsController < ApplicationController

  def index
    if current_merchant
      @merchant = current_user
    else
      render_not_found
    end
  end

end
