class ItemsController < ApplicationController
  def index
    unless params[:type].present?
      @items = Item.first(12)
    else
      @items = Item.where("type = ?", params[:type]).first(12)
    end
  end
  
  def show
    @item = get_by_uid params[:uid]
  end
  
  def update
    @item = get_by_uid params[:uid]
    @item.update item_params
    redirect_to item_path(@item)
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    
    @item.save!
    # Use item_path instead of plain @item to force use of item controller
    # instead of type-specific controller (not implemented (yet))
    redirect_to item_path(@item)
  end
  
  def destroy
    Item.destroy_all(uid: params[:uid])
    redirect_to items_path
  end
  
  private
  def item_params
    params.require(:item).permit(:type, :title, :features_human)
  end
  
  def get_by_uid (uid)
    Item.where("uid LIKE ?", "#{uid}%").first
  end
  
end
