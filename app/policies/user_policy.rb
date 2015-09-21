
class UserPolicy < ApplicationPolicy
  def index?
    # Only admins can view the users listing
    user and user.admin?
  end
  
  def create?
    # Only admins can create new users
    user and user.admin?
  end
  
  def show?
    # All users can view their own user-page, admins can view all users
    user and
      (user.admin? or user == record)
  end
  
  def update?
    show?
  end
end
