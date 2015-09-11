# Mostly to be accessed via ajax, to modify item selection
class SelectionsController < ApplicationController
  def select_single
    authorize :selections
    @item = Item.find_by_uid params[:uid]
    generate_array
    session[:selection] << @item.uid
  end
  
  def deselect_single
    authorize :selections
    session[:selection].delete params[:uid]
  end
  
  def select_array
    authorize :selections
    session[:selection].merge params[:uids]
  end
  
  def deselect_array
    authorize :selections
    session[:selection].subtract params[:uids]
  end
  
  def clear
    authorize :selections
    session[:selection].clear
  end
  
  private
  def generate_array
    unless session[:selection].typeof Array
      session[:selection] = Set.new
    end
  end
end
