class OrderPolicy < ApplicationPolicy
  def index?
    user.admin? || user.regular?
  end

  # Only allow users to view their own order or admins to view any order
  def show?
    user.admin? || user_owns_record?
  end

  # Only admins should be able to update the order status
  def update_status?
    user.admin?
  end

  private

  def user_owns_record?
    record.user == user
  end
end
