require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  let!(:product) { FactoryBot.create(:product) }
  let(:admin_user) { FactoryBot.create(:user, role: 'admin') }
  let(:regular_user) { FactoryBot.create(:user, role: 'regular') }

  before do
    sign_in admin_user
  end

  describe "GET /index" do
    it "returns a successful response for an admin user" do
      get products_path
      expect(response).to have_http_status(:success)
      expect(assigns(:products)).to include(product)
    end
  end

  describe "GET /show" do
    it "shows the product details" do
      get product_path(product)
      expect(response).to have_http_status(:success)
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { name: "New Product", description: "Description", price: 20, stock: 5 } }

    it "creates a new product with valid attributes" do
      expect {
        post products_path, params: { product: valid_attributes }
      }.to change(Product, :count).by(1)
      expect(response).to redirect_to(product_path(Product.last))
    end

    it "does not create a product with invalid attributes" do
      expect {
        post products_path, params: { product: { name: nil } }
      }.not_to change(Product, :count)
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH /update" do
    let(:update_attributes) { { name: "Updated Product" } }

    it "updates the product" do
      patch product_path(product), params: { product: update_attributes }
      expect(response).to redirect_to(product_path(product))
      product.reload
      expect(product.name).to eq("Updated Product")
    end
  end

  describe "DELETE /destroy" do
    it "soft deletes the product" do
      expect {
        delete product_path(product)
      }.to change(Product.with_deleted, :count).by(0)
      expect(Product.only_deleted).to include(product)
      expect(response).to redirect_to(products_path)
    end
  end
end
