class StoreController < ApplicationController

  def index
    @categories = Category.all
    @items = Item.all.available_items
  end

end
