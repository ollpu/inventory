class SessionsController < ApplicationController
  def new
    authorize :sessions
    redirect_to root_path if current_user # User already logged in
    @clear_template = true
  end
  
  def create
    authorize :sessions
    user = User.authenticate params[:email], params[:password]
    if user
      # Login successful
      session[:user_id] = user.id
      redirect_to root_path
    else
      # Login unsuccessful
      @clear_template = true
      render :new
      # TODO: Notify user of unsuccessful login
    end
  end
  
  def destroy
    authorize :sessions
    session[:user_id] = nil
    redirect_to login_path
  end
end
