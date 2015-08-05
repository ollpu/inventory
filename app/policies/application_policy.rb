class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user
  end

  def show?
    user and user.viewer? and
      scope.where(:id => record.id).exists?
  end

  def create?
    user and user.editor?
  end

  def new?
    create?
  end

  def update?
    user and user.editor?
  end

  def edit?
    update?
  end

  def destroy?
    user and user.editor?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
