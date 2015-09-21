class IndexController < ApplicationController
  def index
    unless current_user
      # User not logged in, show login prompt
      skip_authorization
      redirect_to login_path
    else
      authorize :index
    end
  end
end
