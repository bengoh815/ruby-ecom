class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      if turbo_frame_request?
        render turbo_stream: turbo_stream.replace("product_form", partial: "products/show", locals: { product: @product })
      else
        redirect_to @product, notice: "Product was successfully created."
      end
    else
      render turbo_stream: turbo_stream.replace("product_form", partial: "form", locals: { product: @product }), status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      if turbo_frame_request?
        render turbo_stream: turbo_stream.replace("product_form", partial: "products/edit", locals: { product: @product })
      else
        redirect_to @product, notice: "Product was successfully updated."
      end
    else
      render turbo_stream: turbo_stream.replace("product_form", partial: "form", locals: { product: @product }), status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Product was successfully deleted."
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end
end
