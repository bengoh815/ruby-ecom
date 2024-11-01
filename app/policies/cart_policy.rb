class CartPolicy < ApplicationPolicy
  def show?
    user_owns_record?
  end

  def create?
    user.present?
  end

  def destroy?
    user_owns_record?
  end

  private

  def user_owns_record?
    record.user == user
  end
end