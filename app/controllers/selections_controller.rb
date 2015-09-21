# Mostly to be accessed via ajax, to modify item selection
class SelectionsController < ApplicationController
  def select_single
    authorize :selections
    @item = Item.find_by_uid params[:uid]
    generate_set
    session[:selection] << @item.uid
    
    render json: { ok: true }
  end
  
  def deselect_single
    authorize :selections
    @item = Item.find_by_uid params[:uid]
    generate_set
    session[:selection].delete @item.uid
    
    render json: { ok: true }
  end
  
  def select_array
    authorize :selections
    generate_set
    if params[:uids] and params[:uids].is_a?(Array)
      session[:selection].merge params[:uids]
      render json: { ok: true }
    else
      render status: 400, json: { error: 'Invalid input' }
    end
  end
  
  def deselect_array
    authorize :selections
    generate_set
    session[:selection].subtract params[:uids]
    
    render json: { ok: true }
  end
  
  def clear
    authorize :selections
    generate_set
    session[:selection].clear
    
    render json: { ok: true }
  end
  
  private
  def generate_set
    if session[:selection] and session[:selection].is_a? Array
      # Convert array into a Set
      session[:selection] = Set.new(session[:selection])
    else
      session[:selection] = Set.new
    end
  end
end
