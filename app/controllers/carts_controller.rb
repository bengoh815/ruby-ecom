class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :destroy]

  def show
    # Displays the user's current cart
  end

  def create
    @cart = current_user.build_cart
    if @cart.save
      redirect_to cart_path(@cart), notice: "Cart created successfully."
    else
      redirect_to root_path, alert: "Unable to create cart."
    end
  end

  def destroy
    @cart.destroy
    redirect_to root_path, notice: "Cart deleted."
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end