class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def add_product(product_id)
    current_item = cart_items.find_or_initialize_by(product_id: product_id)
    current_item.quantity = (current_item.quantity || 0) + 1
    current_item.save
    current_item
  end

  def total_amount
    cart_items.includes(:product).sum do |item|
      item.quantity * item.product.price
    end
  end
end
