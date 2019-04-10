class Merchants::ItemsController < ApplicationController

  def index
    # binding.pry
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

  def destroy
    item = Item.find(params[:item_id])
    item.destroy
    flash[:alert] = "The item has been deleted."
    redirect_to dashboard_items_path

  def edit
    @merchant = User.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = User.find(params[:id].to_i)
    @item = Item.find(params[:id])
    if @item.update(update_params)
      flash[:notice] =  "Your item has been updated."
      redirect_to dashboard_items_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :current_price, :inventory, :image, :active)
  end

  def update_params
    update_params = params.require(:item).permit(:name, :description, :current_price, :inventory, :image, :active)
    if update_params[:image] == ""
      update_params[:image] = "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg"
    end
    update_params
  end

end
