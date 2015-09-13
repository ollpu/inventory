

class SelectionsPolicy < ApplicationPolicy
  
  def select_single?
    allow_selection_modify?
  end
  
  def deselect_single?
    select_single?
  end
  
  def select_array?
    allow_selection_modify?
  end
  
  def deselect_array?
    select_single?
  end
  
  def clear?
    allow_selection_modify?
  end
  
  private
  def allow_selection_modify?
    user and user.editor?
  end
end
