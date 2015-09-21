class SessionsController < ApplicationController
  def new
    authorize :sessions
    redirect_to root_path if current_user # User already logged in
  end
  
  def create
    authorize :sessions
    user = User.authenticate params[:email], params[:password]
    if user
      # Login successful
      session[:user_id] = user.id
      unless params[:navigate]
        redirect_to root_path
      else
        redirect_to params[:navigate]
      end
      flash.clear;
    else
      # Login unsuccessful
      @clear_template = true
      flash[:alert] = I18n.t(:invalid_credentials, scope: :authorization)
      render :new
    end
  end
  
  def destroy
    authorize :sessions
    session[:user_id] = nil
    redirect_to login_path
  end
end
