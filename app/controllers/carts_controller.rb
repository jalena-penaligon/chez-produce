class CartsController < ApplicationController
  def show
    if current_admin || current_merchant
      render_not_found
    elsif session[:cart] == nil
      flash[:notice] = "Your cart is empty."
    end
  end

  def create
    @item = Item.find(params[:item_id])
    item_id_str = @item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    session[:cart][item_id_str] = session[:cart][item_id_str] + 1
    flash[:notice] = "#{@item.name} has been added to your cart!"
    redirect_to items_path
  end

  def update
    # binding.pry
    if params[:increment] == "add"
      session[:cart][params[:item_id]]+=1
      redirect_to cart_path
    end
  end

  def destroy
    if params[:item_id] == nil
      session[:cart].clear
    else
      session[:cart].delete(params[:item_id])
    end
    redirect_to cart_path
  end
end
