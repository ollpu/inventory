class SessionsController < ApplicationController
  def new
    authorize :sessions
  end
  
  def create
    authorize :sessions
    user = User.authenticate params[:email], params[:password]
    if user
      # Login successful
      session[:user_id] = user.id
      # TODO: Redirect here
    else
      # Login unsuccessful
      render :new
      # TODO: Notify user of unsuccessful login
    end
  end
  
  def destroy
    authorize :sessions
    session[:user_id] = nil
    # TODO: Redirect somewhere
  end
end
