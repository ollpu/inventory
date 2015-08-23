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
    @user = User.find(params[:id])
    authorize @user
    unless @user.update user_update_params(@user) # update record
      # if updating failed (is user invalid?)
      unless @user.valid?
        # User invalid, render form again and display errors
        render 'show'
      else
        # Unexpected situation, display error message
        @user.update! user_update_params(@user)
      end
    else
      # updating successful
      redirect_to user_path(@user), notice: t(:modification_success, scope: [:users, :show])
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
  def user_update_params user_to_update
    unless current_user.admin? and not current_user == user_to_update
      # User is not an admin or is modifying self
      params.require(:user).permit(:email, :password, :password_confirmation,
        :old_password)
    else
      # User is an admin (and not modifying self)
      params.require(:user).permit(:email, :password_admin, :password_confirmation)
    end
  end
  
end
