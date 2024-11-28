class BookPolicy < ApplicationPolicy
  # Admin can access everything
  def index?
    user.admin? || user.manager? || user.customer?
  end

  # Admin and Manager can view books, Customers can view assigned books
  def show?
    user.admin? || user.manager? || user.customer?
  end

  # Only Admin and Manager can create books
  def create?
    user.admin? || user.manager?
  end

  # Only Admin and Manager can update books
  def update?
    user.admin? || user.manager?
  end

  # Only Admin can delete books
  def destroy?
    user.admin?
  end

  # Scope for filtering search results
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.manager?
        scope.joins(:bookstore).where(bookstores: { manager_id: user.id })
      elsif user.customer?
        scope.where(id: user.orders.select(:book_id))
      else
        scope.none
      end
    end
  end
end
