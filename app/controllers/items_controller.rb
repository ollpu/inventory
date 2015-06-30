class ItemsController < ApplicationController
  def index
    unless params[:type].present?
      @items = Item.first(12)
    else
      @items = Item.where("type = ?", params[:type]).first(12)
    end
  end
  
  def show
    @item = Item.where("uid LIKE ?", "#{params[:uid]}%").first
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
