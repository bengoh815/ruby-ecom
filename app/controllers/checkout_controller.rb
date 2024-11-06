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
    # Update order status, empty the cart, or do other post-checkout actions here
  end

  def cancel
    # Handle checkout cancellation
  end
end