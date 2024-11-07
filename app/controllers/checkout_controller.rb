class CheckoutController < ApplicationController
  def create
    # Retrieve the cart items for the current user
    cart = current_user.cart
    line_items = cart.cart_items.map do |item|
      {
        price_data: {
          currency: 'usd',
          product_data: {
            name: item.product.name,
          },
          unit_amount: (item.product.price * 100).to_i,
        },
        quantity: item.quantity,
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: success_checkout_index_url, # Redirect here after successful payment
      cancel_url: cancel_checkout_index_url # Redirect here if payment is canceled
    )

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("checkout_redirect", partial: "checkout/redirect", locals: { url: session.url }) }
      format.html { redirect_to session.url, allow_other_host: true }
    end
  end

  def success
    # Create an order upon successful payment
    cart = current_user.cart
    order = Order.create!(
      user: current_user,
      total_price: cart.total_amount, # Assuming total_amount is a method on the cart to calculate the total
      status: 'completed'
    )

    # Associate cart items with the order
    cart.cart_items.each do |item|
      order.order_items.create!(
        product: item.product,
        quantity: item.quantity,
        price: item.product.price
      )
    end

    # Clear the cart after order is created
    cart.cart_items.destroy_all

    redirect_to order, notice: "Thank you for your purchase! Your order has been successfully created."
  end

  def cancel
    # Handle checkout cancellation
    redirect_to cart_path(current_user.cart), alert: "Checkout was canceled. Please try again."
  end
end