class LineItemsController < ApplicationController

  def create
    current_user.new_cart unless current_user.current_cart
    new_line_item = current_user.current_cart.add_item(params[:item_id])
    if new_line_item.save
      redirect_to cart_path(current_user.current_cart)
    else
      redirect_to store_path
    end
  end

end
