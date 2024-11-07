class CartItemPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user_owns_cart?
  end

  def destroy?
    user_owns_cart?
  end

  private

  def user_owns_cart?
    record.cart.user == user
  end
end
