class LogsController < ApplicationController
  def index
    @logs = Log.all
  end
  
  def show
    @log = Log
  end
  
  def new
    if params[:target].present?
      # Specify target from parameters
      target = [ params[:target] ]
    else
      selection = session[:selection]
      target = if selection and selection.is_a?(Array)
        # Specify target from parameters
        selection.to_a
      else
        # Empty target
        []
      end
    end
    @log = Log.new(items: target)
    authorize @log
  end
  
  
  
  def create
  end
end
