
class LogPolicy < ApplicationPolicy
  def add_affected_item?
    new?
  end
end
