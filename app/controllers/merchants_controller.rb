class MerchantsController < ApplicationController

  def index
    if current_admin
      @merchants = User.all_merchants
    else
      @merchants = User.active_merchants
    end
  end

  def show
    @merchant = current_user
  end
end
