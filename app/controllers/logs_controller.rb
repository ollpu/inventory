class LogsController < ApplicationController
  def index
    @logs = Log.all
  end
  
  def show
    @log = Log
  end
  
  def create
  end
end
