# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create default users
User.create!(email: "admin@example.com", password: "password", role: "admin") unless User.exists?(email: "admin@example.com")
User.create!(email: "user@example.com", password: "password", role: "regular") unless User.exists?(email: "user@example.com")

# Create default products
Product.create!(name: "Wireless Headphones", description: "FAKE PRODUCT! High-quality Bluetooth headphones with noise cancellation", price: 120, stock: 20)
Product.create!(name: "Smartphone Stand", description: "FAKE PRODUCT! Adjustable stand for smartphones and tablets", price: 15, stock: 50)
Product.create!(name: "Portable Charger", description: "FAKE PRODUCT! 10,000mAh power bank for charging devices on the go", price: 30, stock: 25)
Product.create!(name: "Waterproof Speaker", description: "FAKE PRODUCT! Portable waterproof Bluetooth speaker", price: 80, stock: 15)
Product.create!(name: "Fitness Tracker", description: "FAKE PRODUCT! Activity tracker with heart rate monitor and sleep tracking", price: 55, stock: 35)
Product.create!(name: "Wireless Keyboard", description: "FAKE PRODUCT! Compact wireless keyboard for laptops and tablets", price: 40, stock: 10)
Product.create!(name: "Laptop Cooling Pad", description: "FAKE PRODUCT! Cooling pad with adjustable fans for laptops", price: 25, stock: 30)
Product.create!(name: "LED Desk Lamp", description: "FAKE PRODUCT! Adjustable LED desk lamp with touch control", price: 20, stock: 40)
Product.create!(name: "Bluetooth Mouse", description: "FAKE PRODUCT! Ergonomic Bluetooth mouse with customizable buttons", price: 25, stock: 20)
Product.create!(name: "Smart Thermostat", description: "FAKE PRODUCT! Wi-Fi enabled thermostat with smart scheduling", price: 100, stock: 8)
