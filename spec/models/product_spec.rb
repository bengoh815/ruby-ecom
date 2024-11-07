require 'rails_helper'

RSpec.describe Product, type: :model do
  # Factory setup
  let(:product) { build(:product) }

  # 1. Validation Tests
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(product).to be_valid
    end

    it "is invalid without a name" do
      product.name = nil
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a description" do
      product.description = nil
      expect(product).not_to be_valid
      expect(product.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a price" do
      product.price = nil
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is invalid with a non-numeric price" do
      product.price = "ten"
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include("is not a number")
    end

    it "is invalid with a price of 0 or less" do
      product.price = 0
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include("must be greater than 0")
    end

    it "is invalid without a stock value" do
      product.stock = nil
      expect(product).not_to be_valid
      expect(product.errors[:stock]).to include("can't be blank")
    end

    it "is invalid with a non-integer stock" do
      product.stock = 1.5
      expect(product).not_to be_valid
      expect(product.errors[:stock]).to include("must be an integer")
    end

    it "is invalid with a negative stock" do
      product.stock = -1
      expect(product).not_to be_valid
      expect(product.errors[:stock]).to include("must be greater than or equal to 0")
    end
  end

  # 2. Association Tests
  describe "Associations" do
    it "can have many attached images" do
      expect(product.images).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  # 3. Class Method Tests
  describe ".search" do
    let!(:product1) { create(:product, name: "Ruby on Rails", description: "A great book on Rails") }
    let!(:product2) { create(:product, name: "Python Programming", description: "A book on Python") }

    it "returns products matching the query in name" do
      results = Product.search("Ruby")
      expect(results).to include(product1)
      expect(results).not_to include(product2)
    end

    it "returns products matching the query in description" do
      results = Product.search("Python")
      expect(results).to include(product2)
      expect(results).not_to include(product1)
    end

    it "returns all products if query is empty" do
      results = Product.search(nil)
      expect(results).to include(product1, product2)
    end
  end

  # 4. Soft Delete Tests
  describe "Soft Delete (Paranoia)" do
    let!(:product) { create(:product) }

    it "does not delete the product permanently when destroyed" do
      product.destroy
      expect(Product.with_deleted.find_by(id: product.id)).to be_present
    end

    it "excludes soft-deleted products from default scope" do
      product.destroy
      expect(Product.all).not_to include(product)
    end

    it "includes soft-deleted products with .with_deleted scope" do
      product.destroy
      expect(Product.with_deleted).to include(product)
    end

    it "includes only soft-deleted products with .only_deleted scope" do
      product.destroy
      expect(Product.only_deleted).to include(product)
    end

    it "can restore a soft-deleted product" do
      product.destroy
      expect(product.reload.deleted_at).not_to be_nil
      product.restore
      expect(product.reload.deleted_at).to be_nil
    end
  end
end