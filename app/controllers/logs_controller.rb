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
  
  
  
  def create
  end
end
