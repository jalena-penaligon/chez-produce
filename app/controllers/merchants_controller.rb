class MerchantsController < ApplicationController

  def index
  end

  def show
    @merchant = current_merchant
  end

end
