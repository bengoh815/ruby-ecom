# require 'rails_helper'

# RSpec.describe Product, type: :model do
#   # Unit Tests (No database interaction)
#   context "unit tests" do
#     it "is valid with valid attributes" do
#       product = FactoryBot.build(:product)
#       expect(product).to be_valid
#     end

#     it "is invalid without a name" do
#       product = FactoryBot.build(:product, name: nil)
#       expect(product).not_to be_valid
#       expect(product.errors[:name]).to include("can't be blank")
#     end
#   end

#   # Database Interaction Tests
#   context "database interactions" do
#     it "saves a valid product to the database" do
#       product = FactoryBot.create(:product, name: "Persisted Product", price: 200, stock: 15)
#       expect(Product.exists?(product.id)).to be(true)
#     end

#     it "does not save an invalid product to the database" do
#       product = Product.create(name: nil, price: 200, stock: 15)
#       expect(Product.exists?(product.id)).to be(false)
#     end

#     it "fetches a product from the database" do
#       product = FactoryBot.create(:product, name: "Fetchable Product", price: 300, stock: 20)
#       fetched_product = Product.find_by(name: "Fetchable Product")
#       expect(fetched_product).to eq(product)
#     end
#   end
# end

# require 'rails_helper'

# RSpec.describe Product, type: :model do
#   it "can be created in the database" do
#     product = Product.create(name: "Test Product", price: 100, stock: 10)
#     expect(product.persisted?).to be(true)
#   end
# end

require 'rails_helper'

RSpec.describe Product, type: :model do
  fixtures :products  # This line loads the fixtures for Product

  it "uses a fixture product" do
    product = products(:test_product)  # Access the fixture by name
    expect(product.name).to eq("Sample Product")
    expect(product.price).to eq(100)
  end
end