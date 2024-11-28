class BookstorePolicy < ApplicationPolicy
  def index?
    user.admin? || user.manager?
  end

  def show?
    user.admin? || (user.manager? && record.managed_by?(user))
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || (user.manager? && record.managed_by?(user))
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.manager?
        scope.where(manager_id: user.id)
      else
        scope.none
      end
    end
  end
end
