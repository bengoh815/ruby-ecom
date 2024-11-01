class CartItemsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_cart_item, only: [:update, :destroy]

  def create
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product.id)
    authorize @cart_item

    if @cart_item.save
      redirect_to cart_path(@cart), notice: "Item added to cart."
    else
      redirect_to product_path(product), alert: "Unable to add item to cart."
    end
  end

  def update
    authorize @cart_item  # Ensure authorization for updating
    if @cart_item.update(quantity: params[:cart_item][:quantity])
      respond_to do |format|
        format.html { redirect_to cart_path(@cart), notice: "Item updated." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@cart_item), partial: "cart_items/cart_item", locals: { cart_item: @cart_item }) }
      end
    else
      respond_to do |format|
        format.html { redirect_to cart_path(@cart), alert: "Unable to update item." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@cart_item), partial: "cart_items/cart_item", locals: { cart_item: @cart_item }) }
      end
    end
  end

  def destroy
    authorize @cart_item
    @cart_item.destroy
    redirect_to cart_path(@cart), notice: "Item removed."
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
    authorize @cart, :show?
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end
end