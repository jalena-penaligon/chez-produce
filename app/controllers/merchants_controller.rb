class MerchantsController < ApplicationController

  def index
    @merchants = User.active_merchants
  end

  def show
    @merchant = current_user
  end
end
