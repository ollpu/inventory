class SessionsPolicy < ApplicationPolicy
  def create?
    # All viewers are permitted to view the login prompt and attempt to log in
    true
  end
  
  def destroy?
    user # All users are allowed to log out
  end
end
