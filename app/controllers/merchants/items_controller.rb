class Merchants::ItemsController < ApplicationController

  def index
    if current_merchant
      @merchant = current_user
    else
      render_not_found
    end
  end

  def new
    @merchant = User.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    @merchant = User.find(params[:user_id].to_i)
    @item = @merchant.items.create(item_params)
    if @item.save
      flash[:notice] = "You successfully added #{@item.name} to your shop."
      redirect_to dashboard_items_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :current_price, :inventory, :image, :active)
  end

end
