class ProductPolicy < ApplicationPolicy
  def index?
    true  # All users can view the index
  end

  def show?
    true  # All users can view individual products
  end

  def create?
    user.admin?  # Only admins can create products
  end

  def new?
    create?  # Reuse the same logic as create
  end

  def update?
    user.admin?  # Only admins can update products
  end

  def edit?
    update?  # Reuse the same logic as update
  end

  def destroy?
    user.admin?  # Only admins can delete products
  end

  def restore?
    destroy?
  end

  def deleted?
    destroy?
  end

  # Scope class to limit which records are shown
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end