class ItemsController < ApplicationController
  def index
    unless params[:type].present?
      @items = Item.first(12)
    else
      @items = Item.where("type = ?", params[:type]).first(12)
    end
    authorize Item.new
  end
  
  def show
    @item = Item.find_by_uid params[:uid]
    authorize @item.becomes(Item)
  end
  
  # Redirects to /items/[:uid]#edit,
  # editing form is then handled by javascript.
  def edit
    @item = Item.find_by_uid params[:uid]
    authorize @item.becomes(Item)
    redirect_to item_path(@item) << '#edit'
  end
  
  def update
    @item = Item.find_by_uid params[:uid]
    authorize @item
    @item.update item_params
    redirect_to item_path(@item)
  end
  
  def new
    @item = Item.new
    authorize @item.becomes(Item)
  end
  
  def create
    @item = Item.new(item_params)
    authorize @item.becomes(Item)
    if @item.save
      # Use item_path instead of plain @item to force use of item controller
      # instead of type-specific controller (not implemented (yet))
      redirect_to item_path(@item)
    else
      render 'new'
    end
  end
  
  def destroy
    authorize params[:uid]
    Item.destroy_all(uid: params[:uid])
    redirect_to items_path
  end
  
  private
  def item_params
    params.require(:item).permit(:type, :title, :features_human)
  end
  
  
  
end
