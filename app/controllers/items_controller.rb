class ItemsController < ApplicationController
  def index
    @items = Item.first(12)
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    
    @item.save
    # Use item_path instead of plain @item to force use of item controller
    # instead of type-specific controller (not implemented (yet))
    redirect_to item_path(@item)
  end
  
  private
  def item_params
    params.require(:item).permit(:type)
  end
  
end
