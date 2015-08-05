class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Privilige management
  include Pundit
  after_action :verify_authorized
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  helper_method :current_user
  
  private
  
  def user_not_authorized
    flash[:alert] = "Please log in first." # Tranlslate!
    redirect_to login_path
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
