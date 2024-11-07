class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :update_status]
  after_action :verify_authorized, except: [:index]

  def index
    authorize Order
    @orders = current_user.admin? ? Order.all : current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def create
    @order = current_user.orders.build(total_price: calculate_total_price)
    authorize @order

    current_user.cart.cart_items.each do |cart_item|
      @order.order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end

    if @order.save
      current_user.cart.cart_items.destroy_all  # Empty the cart
      redirect_to @order, notice: "Order was successfully placed."
    else
      redirect_to cart_path, alert: "There was an issue placing your order."
    end
  end

  def update_status
    authorize @order, :update_status?
    if @order.update(order_status_params)
      redirect_to @order, notice: "Order status updated successfully."
    else
      redirect_to @order, alert: "Failed to update order status."
    end
  end

  private

  def calculate_total_price
    current_user.cart.cart_items.sum { |item| item.product.price * item.quantity }
  end

  def set_order
    @order = Order.find(params[:id])
    authorize @order
  end

  def order_status_params
    params.require(:order).permit(:status)
  end
end