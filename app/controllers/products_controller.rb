class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_product, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index]

  def index
    @products = policy_scope(Product)
  end

  def show
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product
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
  end

  def update
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
    @product.destroy
    redirect_to products_path, notice: "Product was successfully deleted."
  end

  private

  def set_and_authorize_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end
end