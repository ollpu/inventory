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
    unless current_user
      # Not logged in
      flash[:notice] = t(:no_user, scope: :authorization)
      redirect_to login_path(navigate: request.env['PATH_INFO'])
    else
      # Logged in but not otherwise authorized
      flash[:alert] = t(:not_authorized, scope: :authorization)
      redirect_to root_path
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
