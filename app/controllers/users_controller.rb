class UsersController < ApplicationController
  def new
    @user = User.new
    authorize @user
  end
  
  def show
    @user = User.find(params[:id])
    authorize @user
  end
  
  def update
    @user = User.new(user_params)
    # A new password is 
    user.save!
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
  
end
