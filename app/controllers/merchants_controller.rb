class MerchantsController < ApplicationController

  def index
    @merchants = User.active_merchants
  end

end
