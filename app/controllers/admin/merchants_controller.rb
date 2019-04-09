class Admin::MerchantsController < ApplicationController
  def show
    @merchant = User.find(params[:id])
  end

  def downgrade
    if current_admin
      merchant = User.find(params[:id])
      merchant.role = 'user'
      merchant.items.update_all(active: false)
      merchant.save
      redirect_to admin_user_path(merchant)
      flash[:notice] = "Merchant is now downgraded to regular user."
    else
      render_not_found
    end
  end
end
