class SessionsPolicy < ApplicationPolicy
  def new?
    true # All viewers are permitted to view the login prompt
  end
  
  def destroy?
    user # All users are allowed to log out
  end
end
