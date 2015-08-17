class UsersController < ApplicationController
  def new
    @user = User.new
    authorize @user
  end
  
  def show
    @user = User.find(params[:id])
    authorize @user
  end
  
end
