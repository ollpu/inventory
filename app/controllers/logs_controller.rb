class LogsController < ApplicationController
  def index
    @logs = Log.all
  end
  
  def show
    @log = Log
  end
  
  def new
    target = params[:target]
    # :items => [ target ] or [ ] if "target" isn't supplied
    @log = Log.new(items: target.present? ? [target] : [])
    authorize @log
  end
  
  # AJAX for affected items list
  def add_affected_item
    log = Log.new
    authorize log
    
    @item = Item.find_by_uid params[:uid]
    if params[:uid].present? and @item
      render action: 'add_affected_item', layout: false
    else
      render nothing: true
    end
  end
  
  def create
  end
end
