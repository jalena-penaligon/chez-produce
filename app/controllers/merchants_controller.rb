class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 1, active: true)
  end

end
